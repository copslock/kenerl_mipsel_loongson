Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6H8xGRw002974
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 01:59:16 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6H8xGDL002973
	for linux-mips-outgoing; Wed, 17 Jul 2002 01:59:16 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6H8x6Rw002879;
	Wed, 17 Jul 2002 01:59:06 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6H93uXb001671;
	Wed, 17 Jul 2002 02:03:56 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA11755;
	Wed, 17 Jul 2002 02:03:55 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6H93ub05893;
	Wed, 17 Jul 2002 11:03:56 +0200 (MEST)
Message-ID: <3D3532FB.E227A5AD@mips.com>
Date: Wed, 17 Jul 2002 11:03:55 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>, Ralf Baechle <ralf@oss.sgi.com>,
   linux-mips@oss.sgi.com
Subject: pread and pwrite
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm running some tests from LTP, which tests pread and pwrite.
It look like pread/pwrite doesn't do any check, if they are called with
'buf =NULL' or 'offset < 0', and no error is return.
If I look in glibc in sysdeps/generic/pread.c it look like this:

ssize_t
__libc_pread (int fd, void *buf, size_t nbytes, off_t offset)
{
  if (nbytes == 0)
    return 0;
  if (fd < 0)
    {
      __set_errno (EBADF);
      return -1;
    }
  if (buf == NULL || offset < 0)
    {
      __set_errno (EINVAL);
      return -1;
    }

  __set_errno (ENOSYS);
  return -1;
}

Here there is some checking for sane values and a proper error value is
return.
I guess this routine is replaced, if we have the syscall implemented
with the sysdeps/unix/sysv/linux/mips/pread.c file.
Here there is no check for sane values, is there any reason why ?
The same thing goes for pwrite.

/Carsten

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
