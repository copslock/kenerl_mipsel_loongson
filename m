Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2011 21:07:53 +0200 (CEST)
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:51420 "EHLO
        mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903605Ab1J0THt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Oct 2011 21:07:49 +0200
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1319742468; l=1958;
        s=domk; d=haible.de;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:To:
        From:X-RZG-CLASS-ID:X-RZG-AUTH;
        bh=s0bZ3vlFcVBoKURZe0ytfraRoCQ=;
        b=Wtx0Tz2Z8WI2uPmH5ms2AJi/9RkGDmCuTQJodFs5YB0EpFyUlshFOxuVYa53NR5vCim
        DYj3GDcIrsF1nXUyksyp5YaGd4KHmoog4/enjow830KClW5cI5u0Cs/9Qmiz2U2pZT4cr
        ugAkyoOEr1Z+1Owi0sooHq9dPY6622VxBVc=
X-RZG-AUTH: :Ln4Re0+Ic/6oZXR1YgKryK8brksyK8dozXDwHXjf9hj/zDNRb/Q45hFP
X-RZG-CLASS-ID: mo00
Received: from linuix.haible.de
        (dslb-088-068-062-040.pools.arcor-ip.net [88.68.62.40])
        by post.strato.de (mrclete mo6) (RZmta 26.10 AUTH)
        with ESMTPA id z01fcbn9RGYjFO ; Thu, 27 Oct 2011 21:07:39 +0200 (MEST)
From:   Bruno Haible <bruno@clisp.org>
To:     bug-gnulib@gnu.org, linux-mips@linux-mips.org
Subject: bug in fchownat in n32 and 64 ABIs
Date:   Thu, 27 Oct 2011 21:07:38 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.37.6-0.5-desktop; KDE/4.6.0; x86_64; ; )
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <201110272107.38510.bruno@clisp.org>
X-archive-position: 31313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno@clisp.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19901

Hi Linux/MIPS folks,

Found this bug by running the gnulib POSIX test suite: In the fchownat()
call, an uid_t or gid_t of value (uid_t)-1 or (gid_t)-1 means no change.
See <http://pubs.opengroup.org/onlinepubs/9699919799/functions/fchownat.html>.
This value is correctly recognized on all Unices, _except_ Linux/MIPS
in n32 and 64 ABIs.

How to reproduce:
==================================== foo.c ====================================
#define _GNU_SOURCE 1
#include <fcntl.h>
#include <stdio.h>
#include <sys/stat.h>
#include <unistd.h>
int
main ()
{
  const char *filename = "foo.c";
  struct stat statbuf;
  int ret;
  int result = 0;

  ret = stat (filename, &statbuf);
  if (ret < 0)
    {
      perror ("stat");
      return 1;
    }
  else
    {
      ret = fchownat (AT_FDCWD, filename, (uid_t)-1, statbuf.st_gid, 0);
      if (ret < 0)
        {
          perror ("fchownat");
          result |= 2;
        }
      ret = fchownat (AT_FDCWD, filename, statbuf.st_uid, (gid_t)-1, 0);
      if (ret < 0)
        {
          perror ("fchownat");
          result |= 4;
        }
      ret = fchownat (AT_FDCWD, filename, (uid_t)-1, (gid_t)-1, 0);
      if (ret < 0)
        {
          perror ("fchownat");
          result |= 8;
        }
    }
  return result;
}
===============================================================================
$ gcc -Wall -mabi=64 foo.c
$ ./a.out ; echo $?
fchownat: Operation not permitted
fchownat: Operation not permitted
fchownat: Operation not permitted
14
$ gcc -Wall -mabi=n32 foo.c
$ ./a.out ; echo $?
fchownat: Operation not permitted
fchownat: Operation not permitted
fchownat: Operation not permitted
14
$ gcc -Wall -mabi=32 foo.c
$ ./a.out ; echo $?

Other relevant data:
- kernel version is 2.6.27.1
- glibc version is 2.7
- gcc version is 4.3.2 (Debian).

'strace' of this program shows that the system call that returns with -1/EPERM
is a call to SYS_6254 (in n32 ABI) or SYS_5250 (in 64 ABI).

Bruno
-- 
In memoriam Helmuth Hübener <http://en.wikipedia.org/wiki/Helmuth_Hübener>
