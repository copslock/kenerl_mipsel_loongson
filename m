Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Jul 2006 23:41:57 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:59410 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133883AbWG3Wlr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 30 Jul 2006 23:41:47 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 00ED664D54; Sun, 30 Jul 2006 22:41:38 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 811BB66BCD; Mon, 31 Jul 2006 00:41:37 +0200 (CEST)
Date:	Mon, 31 Jul 2006 00:41:37 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	Roger Leigh <rleigh@debian.org>, 380531-silent@bugs.debian.org
Subject: Re: Bug#380531: linux-2.6: mips and mipsel personality(2) support is broken
Message-ID: <20060730224137.GP17134@deprecation.cyrius.com>
References: <20060730183939.7119.48747.reportbug@hardknott.home.whinlatter.ukfsn.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20060730183939.7119.48747.reportbug@hardknott.home.whinlatter.ukfsn.org>
User-Agent: Mutt/1.5.11+cvs20060403
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FYI, but report tht "mips and mipsel personality(2) support is broken"

* Roger Leigh <rleigh@debian.org> [2006-07-30 19:39]:
> personality(2) only works the first time it is called [in the lifetime
> of a process/program].  All subsequent calls return EPERM, which is
> not a documented return value; I can see no mention of it in
> kernel/execdomain.c.  None of the other architectures I have tested
> (amd64, arm, i386, ia64, powerpc) behave this way: personality(2) is
> not a privileged call.
> 
> This happens no matter what the value of persona is, even if it is
> just 0xffffffff to query the current personality.
> 
> The attached testcase demonstrates the breakage.  On a working
> platform (powerpc), the output is like this:
> 
> ------------------------
> $ ./testpersona
> Getting personality
> Get returned '0'
> Setting personality '8'
> Set OK
> Getting personality
> Get returned '8'
> Setting personality '0'
> Set OK
> Getting personality
> Get returned '0'
> ------------------------
> 
> 0 == PER_LINUX
> 8 == PER_LINUX32
> 
> It successfully switched from PER_LINUX to PER_LINUX32 and back again,
> checking the personality before and after each change.
> 
> 
> Regards,
> Roger

-- 
Martin Michlmayr
http://www.cyrius.com/

--h31gzZEtNLTqOjlF
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="testpersona.c"

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <sys/personality.h>

int
set_persona (unsigned long p)
{
  fprintf (stderr, "Setting personality '%lu'\n", p);

  int status = personality(p);
  if (status == -1)
    fprintf(stderr, "Set failed: %s\n", strerror(errno));

  fprintf(stderr, "Set OK\n");

  return status;
}

int
get_persona (void)
{
  fprintf (stderr, "Getting personality\n");

  int status = personality(0xffffffff);
  if (status == -1)
    fprintf(stderr, "Get failed: %s\n", strerror(errno));

  fprintf(stderr, "Get returned '%d'\n", status);

  return status;
}

int
main (void)
{
  get_persona();
  set_persona(PER_LINUX32);
  get_persona();
  set_persona(PER_LINUX);
  get_persona();
  return 0;
}

--h31gzZEtNLTqOjlF--
