Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2007 19:47:36 +0000 (GMT)
Received: from static-72-72-73-123.bstnma.east.verizon.net ([72.72.73.123]:23306
	"EHLO mail.sicortex.com") by ftp.linux-mips.org with ESMTP
	id S20021615AbXCITrF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Mar 2007 19:47:05 +0000
Received: from srv050.sicortex.com (srv050.sicortex.com [10.2.0.50])
	by mail.sicortex.com (Postfix) with ESMTP id 882BE16145C;
	Fri,  9 Mar 2007 14:46:26 -0500 (EST)
Received: by srv050.sicortex.com (Postfix, from userid 1065)
	id 5EC915314E; Fri,  9 Mar 2007 14:46:26 -0500 (EST)
From:	Peter Watkins <pwatkins@sicortex.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: [PATCH] Have sigpoll and sigio band field match glibc for n64
Date:	Fri,  9 Mar 2007 14:46:25 -0500
Message-Id: <1173469586997-git-send-email-pwatkins@sicortex.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: [PATCH] Have sigpoll and sigio band field match glibc for n64
References: [PATCH] Have sigpoll and sigio band field match glibc for n64
Return-Path: <pwatkins@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pwatkins@sicortex.com
Precedence: bulk
X-list: linux-mips

Hello,

The siginfo field si_fd is incorrect on n64 because the band field does not match glibc.

The patch is in the next mail. Tested on Malta and Sicortex. Below is how to reproduce the problem.

run ./sigio on mips64 testmachine
on another machine, telnet testmachine 8888

Correct output:
gcc -o sigio sigio.c -mabi=n32
./sigio
fd 3 sock 4
sigio : fd 1065
sigio : fd 4
sigio : fd 4
sigio : fd 4
sigio : fd 4
sigio : fd 4
sigio : fd 4
...

Incorrect output:
gcc -o sigio sigio.c -mabi=64
./sigio
fd 3 sock 4
sigio : fd 1065
sigio : fd 0
sigio : fd 0
sigio : fd 0
sigio : fd 0
sigio : fd 0


Test program (from Andrew Gierth)

#define _GNU_SOURCE 1
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <sys/time.h>

#include <netinet/in.h>

#include <stdio.h>
#include <stdarg.h>
#include <signal.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

#define TCP_PORT 8888

/* This example uses SIGIO and SIGURG on a TCP socket for convenience. */
/* In practice, SIGIO is almost useless on stream sockets, because it  */
/* gets generated by far too many different events.                    */
/* To test, just telnet to port 8888. Use telnet's 'synch' command to  */
/* generate OOB data for SIGURG.                                       */
/* The program simply echos data in hex, bracketing all 'urgent' data  */
/* in [].                                                              */

/* I say again: USE SIGIO ON STREAM SOCKETS ONLY AS A LAST RESORT. */

/* handle cruft */

#if EWOULDBLOCK == EAGAIN
# define IS_WOULDBLOCK(err) ((err)==EAGAIN)
#else
# define IS_WOULDBLOCK(err) (((err)==EAGAIN)||((err)==EWOULDBLOCK))
#endif

/* useful functions */

void errexit(const char *msg)
{
    perror(msg);
    exit(1);
}

/* this is done this way in an attempt to be safe in a signal handler. */

void complain(const char *msg,...)
{
    va_list va;
    char buf[1024];

    va_start(va,msg);
    vsprintf(buf, msg, va);
    va_end(va);

    write(STDERR_FILENO, buf, strlen(buf));
}

/* might need fcntl(F_SETFL), or ioctl(FIONBIO) */
/* Posix.1g says fcntl */
/* NEVER, EVER USE O_NDELAY HERE */

#ifdef O_NONBLOCK

int set_nonblock(int fd)
{
    int flags = fcntl(fd, F_GETFL, 0);
    if (flags == -1)
	return -1;
    return fcntl(fd, F_SETFL, flags | O_NONBLOCK);
}

#else

int set_nonblock(int fd)
{
    int yes = 1;
    return ioctl(fd, FIONBIO, &yes);
}

#endif

/* might need fcntl(F_SETOWN), or ioctl(FIOSETOWN), or ioctl(SIOCSPGRP) */
/* Posix.1g says fcntl */

#ifdef F_SETOWN

int set_owner(int fd)
{
    return fcntl(fd, F_SETOWN, getpid());
}

#else

int set_owner(int fd)
{
    pid_t pid = getpid();
    return ioctl(fd, FIOSETOWN, &pid);
}

#endif

/* might need fcntl(F_SETFL), or ioctl(FIOASYNC) */
/* Posix.1g says fcntl */
/* DONT use I_SETSIG unless portability isn't an issue - remember, */
/* SOCKETS ARE NOT STREAMS! */

#ifdef O_ASYNC

int set_async(int fd)
{
    int flags = fcntl(fd, F_GETFL, 0);
    if (flags == -1)
	return -1;
    return fcntl(fd, F_SETFL, flags | O_ASYNC);
}

#else

int set_async(int fd)
{
    int yes = 1;
    return ioctl(fd, FIOASYNC, &yes);
}

#endif

int sockatmark(int sock)
{
    int flag = 0;
    if (ioctl(sock, SIOCATMARK, &flag) < 0)
	return -1;
    return (flag != 0) ? 1 : 0;
}

/* Ought to be able to do this with SIOCATMARK, but on my FreeBSD system */
/* it wasn't behaving in any sort of consistent fashion. */

int urgent_pending(int sock)
{
    struct timeval tv;
    fd_set fds;

    FD_ZERO(&fds);
    FD_SET(sock,&fds);
    tv.tv_sec = 0;
    tv.tv_usec = 0;

    return select(sock+1,NULL,NULL,&fds,&tv);
}

/*-------------------------------------------------------------------------*/

int sock;

sigset_t sigio_set;
sigset_t sigurg_set;
sigset_t empty_set;

volatile sig_atomic_t urgmode = 0;
volatile sig_atomic_t sigiocount = 0;
volatile sig_atomic_t sigurgcount = 0;

void sigio_handler(int sig, struct siginfo *info, void *data)
{
    char inbuf[64];
    char outbuf[4];
    int i,rc,flag;
    sigset_t sigs;

    sigiocount++;
    complain("sigio : fd %d \n", info->si_fd);
    for (;;)
    {
	rc = read(sock, inbuf, sizeof(inbuf));
	if (rc < 0 && IS_WOULDBLOCK(errno))
	    return;

	if (rc < 0)
	{
	    complain("error on read: %d (%s)\n", errno, strerror(errno));
	    _exit(1);
	}
	if (rc == 0)
	{
	    complain("Done.\n");
	    complain("Total SIGIOs : %ld\n", (long) sigiocount);
	    complain("Total SIGURGs: %ld\n", (long) sigurgcount);
	    _exit(0);
	}
	
	for (i = 0; i < rc; i++)
	{
	    outbuf[0] = ' ';
	    outbuf[1] = "0123456789ABCDEF"[(inbuf[i] >> 4) & 0x0F];
	    outbuf[2] = "0123456789ABCDEF"[inbuf[i] & 0x0F];
	    write(sock, outbuf, 3);
	}
	
	sigprocmask(SIG_BLOCK, &sigurg_set, &sigs);
	
	if (urgmode && !urgent_pending(sock))
	{
	    write(sock, "]", 1);
	    urgmode = 0;
	}

	sigprocmask(SIG_SETMASK, &sigs, NULL);
    }
}

void sigurg_handler(int sig)
{
    sigurgcount++;
    urgmode = 1;
    write(sock, " [", 2);
}


main()
{
    struct sigaction sa;
    struct sockaddr_in addr;
    int addrlen = sizeof(addr);
    int fd = socket(AF_INET, SOCK_STREAM, 0);
    int yes = 1;

    if (fd < 0)
	errexit("socket");

    sigemptyset(&empty_set);
    sigemptyset(&sigio_set);
    sigaddset(&sigio_set,SIGIO);
    sigemptyset(&sigurg_set);
    sigaddset(&sigurg_set,SIGURG);

    if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(int)) < 0)
	errexit("setsockopt");

    /* set this in the listen socket; it will be inherited. */

    if (setsockopt(fd, SOL_SOCKET, SO_OOBINLINE, &yes, sizeof(int)) < 0)
	errexit("setsockopt");

    addr.sin_family = AF_INET;
    addr.sin_port = htons(TCP_PORT);
    addr.sin_addr.s_addr = INADDR_ANY;

    if (bind(fd, (struct sockaddr *) &addr, addrlen) < 0)
	errexit("bind");

    if (listen(fd,5) < 0)
	errexit("listen");

    sock = accept(fd, (struct sockaddr *) &addr, &addrlen);

    if (sock < 0)
	errexit("accept");

    printf("fd %d sock %d\n", fd, sock);
    close(fd);

    /* block SIGIO and SIGURG while we set everything up. */

    sigprocmask(SIG_BLOCK, &sigio_set, NULL);
    sigprocmask(SIG_BLOCK, &sigurg_set, NULL);

    if (set_nonblock(sock) < 0)
	errexit("set_nonblock");

    if (set_owner(sock) < 0)
	errexit("set_owner");

    if (set_async(sock) < 0)
	errexit("set_async");

    sa.sa_handler = sigio_handler;
    sa.sa_flags = SA_SIGINFO;
    sigemptyset(&sa.sa_mask);
    sigaction(SIGIO, &sa, NULL);

    sa.sa_handler = sigurg_handler;
    sa.sa_flags = 0;
    sa.sa_mask = sigio_set;
    sigaction(SIGURG, &sa, NULL);


    int ret;
    ret = fcntl(sock, F_SETSIG, SIGIO);
    if (ret == -1) {
        printf("cannot setsig: %s\n", strerror(errno));
	errexit("setsig");
    }


    /* data may have arrived while we were setting up, so generate */
    /* SIGIO now. */

    raise(SIGIO);

    /* unblock everything, then pause. */

    sigprocmask(SIG_SETMASK, &empty_set, NULL);

    for(;;)
	pause();

    /*NOTREACHED*/

    return 0;
}
