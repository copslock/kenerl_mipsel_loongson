Received:  by oss.sgi.com id <S305182AbQEROWW>;
	Thu, 18 May 2000 14:22:22 +0000
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:37939 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305181AbQEROWE>; Thu, 18 May 2000 14:22:04 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA02097; Thu, 18 May 2000 07:26:36 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id HAA23190; Thu, 18 May 2000 07:21:32 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA68240
	for linux-list;
	Thu, 18 May 2000 07:11:52 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA95308
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 18 May 2000 07:11:50 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.30]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA08734
	for <linux@cthulhu.engr.sgi.com>; Thu, 18 May 2000 07:11:49 -0700 (PDT)
	mail_from (agx@bert.physik.uni-konstanz.de)
Received: from bert.physik.uni-konstanz.de [134.34.144.20] 
	by gandalf.physik.uni-konstanz.de with smtp (Exim 2.05 #1 (Debian))
	id 12sR1d-0000jv-00; Thu, 18 May 2000 16:11:45 +0200
Received: by bert.physik.uni-konstanz.de (sSMTP sendmail emulation); Thu, 18 May 2000 16:11:36 +0200
Date:   Thu, 18 May 2000 16:11:36 +0200
From:   Guido Guenther <agx@bert.physik.uni-konstanz.de>
To:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Subject: SIGIO Handler
Message-ID: <20000518161135.A26055@bert.physik.uni-konstanz.de>
Mail-Followup-To: Guido Guenther <guido.guenther@uni-konstanz.de>,
	linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.1.9i
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm still trying to get the mouse to work under X. The problem seems not
to be related to X itself but to a kernel/glibc problem. X uses a SIGIO
handler to "get notified" about mouse events. I wrote my own small SIGIO
handler(see attached program) which works fine on my intel box but not
on an indy (glibc-2.0.6-3lm/linux-2.2.13-20000211). Could please someone
else run the attached program on mips/mipsel and check if it works or
give me a hint where to start to look for the problem.
Regards,
 -- Guido

-- 
GPG-Public Key: http://honk.physik.uni-konstanz.de/~agx/guenther.gpg.asc

--YZ5djTAD1cGYuMQK
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="sigio.c"

# include <unistd.h>
# include <signal.h>
# include <fcntl.h>
# include <sys/time.h>
# include <errno.h>
# include <stdio.h>
# include <string.h>

static int fd = 0;
fd_set sig_mask;

static void
sigio_handler (int sig)
{
	int	    i;
	fd_set  ready;
	struct timeval  to;
	int	    r;

	ready = sig_mask;
	to.tv_sec = 0;
	to.tv_usec = 0;
	while(((r = select (fd+1, &ready, 0, 0, &to)) == -1) && (errno == EINTR));
	if (FD_ISSET (fd, &ready))
    		printf("SIGIO Handler for fd %d\n", fd);
}

main()
{
	struct sigaction sa;
	struct sigaction osa;

	printf("Installing SIGIO handler for fd: %d\n", fd);
	printf("Hitting return should call the SIGIO Handler\n");
	sigemptyset(&sa.sa_mask);
	sigaddset(&sa.sa_mask, SIGIO);
	sa.sa_flags   = 0;
	sa.sa_handler = sigio_handler;
	sigaction(SIGIO, &sa, &osa);

	FD_SET (fd, &sig_mask);
	if (fcntl(fd, F_SETOWN, getpid()) == -1) {
		printf("fcntl(%d, F_SETOWN): %s\n", fd, strerror(errno));
		return 1;
	}
	if (fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_ASYNC) == -1) {
		printf("fcntl(%d, O_ASYNC): %s\n", fd, strerror(errno));
		return 1;
	}
	while(1);
	return 0;
}

--YZ5djTAD1cGYuMQK--
