Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5JGBf022226
	for linux-mips-outgoing; Tue, 19 Jun 2001 09:11:41 -0700
Received: from miya ([194.90.113.98])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5JGBcV22223
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 09:11:39 -0700
Received: from miya (IDENT:shay@localhost.localdomain [127.0.0.1])
	by miya (8.9.3/8.9.3) with SMTP id TAA12410
	for <linux-mips@oss.sgi.com>; Tue, 19 Jun 2001 19:14:22 +0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Shay Deloya <shay@miya.sgi.com>
To: linux-mips@oss.sgi.com
Subject: Creating a mips tool chain for mips3
Date: Tue, 19 Jun 2001 19:14:22 +0300
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01061919142200.12304@miya>
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

At the moment I use tool chain of  egcs-2.90.29 glibc-2.0.6.
I see that the default crtbegin (egcs)  is compiled for mips1 and when I use
mips-linux-gcc -mips3 hello.c , I get the following error:
ISA mismatch (-mips3) with previous modules (-mips1)
Bad value: failed to merge target specific data of file /tmp/ccVx4c701.o

When I check I see that crtbegin & crtend are of mips1 type.

How can I configure the gcc and glibc to be compiled as mips3 and not mips1 
by default ? 

Shay
