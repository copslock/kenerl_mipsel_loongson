Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2007 11:13:33 +0100 (BST)
Received: from web8408.mail.in.yahoo.com ([202.43.219.156]:64377 "HELO
	web8408.mail.in.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20024696AbXJDKNY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 4 Oct 2007 11:13:24 +0100
Received: (qmail 51544 invoked by uid 60001); 4 Oct 2007 10:12:16 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=mDS6HF5YgniWNe6qHchj1YFWcg1Cx3Z/oa1B0ZMTAyO+/sxhZ9EPYawAOIcs1Ihn1jE06qg9HWEZk+C5jcnD7CN151IytMSZ3TpBBk7iJmlKBSxW9x+PZFNCKmAHH7TSYHZHImqcJthYcaw5Vrm6BWnPLriQabvpLaLNKFkiJ7w=;
X-YMail-OSG: Et3xM6gVM1lBqhII.7EvY_7.97tfd61BpJw358sR8E1VXPZsXZTlxTgQpSU59V1rm.XT7M5yrLz5yCyy9uoFikPsBbj9y9Kvq9duyE9sa.6qF0P9AINd7xBeEz1gKQ--
Received: from [199.239.167.162] by web8408.mail.in.yahoo.com via HTTP; Thu, 04 Oct 2007 11:12:16 BST
Date:	Thu, 4 Oct 2007 11:12:16 +0100 (BST)
From:	veerasena reddy <veerasena_b@yahoo.co.in>
Subject: unresoved symbol _gp_disp
To:	linux-mips <linux-mips@linux-mips.org>,
	"linux-kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <230962.51223.qm@web8408.mail.in.yahoo.com>
Return-Path: <veerasena_b@yahoo.co.in>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: veerasena_b@yahoo.co.in
Precedence: bulk
X-list: linux-mips

Hi,

  I am using buildroot to build toolchain (GCC ver
3.4.3, binutil-1.15 and ucLibc-0.9.28, linux-2.6.18
kernel) for MIPS processor with soft float option
enabled.

I have written a loadble module ( which gets complied
along with kernel) which does some floating point
operation.
 
When i try to load the module i get the following
error
"unresoved symbol _gp_disp".
===================================================
below is from MIPS FAQ which also doesn't help:

Insmod complains about the _gp_disp symbol being
undefined
_gp_disp is a magic symbol used with PIC code on MIPS.
Be happy, this error message saved you from crashing
your system. You should use the same compiler options
to compile a kernel module as the kernel makefiles do.
In particular the options -mno-pic -mno-abicalls -G 0
are important.
===================================================
 
In fact i tried with -mno-abicalls -fno-pic  compiler
options still i see the same problem.
 
Could you please give me some pointers on this issue.
BTW, How to compile libgcc.a with "-G 0" options.
In which file of buildroot i shoul added these options
to get effective.
 
Thanks in advance.
 
Regards,
Veerasena.


      Unlimited freedom, unlimited storage. Get it now, on http://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
