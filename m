Received:  by oss.sgi.com id <S553792AbRAUX46>;
	Sun, 21 Jan 2001 15:56:58 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:27405 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553785AbRAUX4p>; Sun, 21 Jan 2001 15:56:45 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 14KULi-0001MD-00; Mon, 22 Jan 2001 00:56:42 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 14KULi-0001xS-00; Mon, 22 Jan 2001 00:56:42 +0100
Date:   Mon, 22 Jan 2001 00:56:42 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@oss.sgi.com
Subject: pthread in glibc 2.2.1
Message-ID: <20010122005642.A7516@bilbo.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
even the simplest pthread-program dies with a bus error(see attachment)
on my I2.  glibc is 2.2.1(same for 2.1.97), kernel is 2.4.0-test9.
Interesting enough I can't even get a core dump. Any starting points to
track this down?
Regards, 
 -- Guido

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Description: pthread_create.c
Content-Disposition: attachment; filename="pthreadcreate.c.orig"

#include <pthread.h>
#ifndef NULL
#define NULL (void*)0
#endif

static void *task(p)
	void *p;
{
	return (void *) (p == NULL);
}

int main(argc, argv)
	int argc;
	char **argv;
{
	pthread_t t;
	exit(pthread_create(&t, NULL, task, NULL));
}


--YiEDa0DAkWCtVeE4--
