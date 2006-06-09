Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Jun 2006 18:25:07 +0100 (BST)
Received: from web31505.mail.mud.yahoo.com ([68.142.198.134]:15190 "HELO
	web31505.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133654AbWFIRY4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 Jun 2006 18:24:56 +0100
Received: (qmail 23751 invoked by uid 60001); 9 Jun 2006 17:24:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=6ZWLD68av36OZN6pZMvC4g3MZ/X1zb2iDNNyWtAjgvG5s2CQpSnyLtuoNotw4C3JfIMPt8ZRaXluyYrQj9i476LumgC6gv4rX6vzeXXhSruKD1pZr6KEkHnvtEvSS0ObOiSviF4g9aPCHSm3a5dvd406RE1uKekORXQGMdGRYVQ=  ;
Message-ID: <20060609172443.23749.qmail@web31505.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31505.mail.mud.yahoo.com via HTTP; Fri, 09 Jun 2006 10:24:43 PDT
Date:	Fri, 9 Jun 2006 10:24:43 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: re: where I can find a crosscompiler for BCM1255
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

I have built cross-compilers for the Broadcom BCM1250
using the instructions and patches on the "Linux From
Scratch" website. You need to look for the
cross-compiler version of their guide, then select
"browse online" and finally "mips64" to get to the
instructions/patches for building for the 64-bit MIPS
platforms.

Do NOT use their kernel or kernel patches - use the
version in the git repository on linux-mips.

I personally use the binutils from CVS, rather than
the version they have on their website, but there are
no guarantees that their alterations to their MIPS
code has fixed bugs or added them. This is NOT a
well-tested or well-supported platform, even by (or
especially by, in Broadcom's case) the manufacturers.

I have the C, C++ and GFortran compilers working. It
would appear to be much harder to get ADA to work. I
have not tried Objective C or Objective C++.

(GFortran is buggy, but efforts to get G95 to compile
correctly are so far proving very frustrating. It
compiles natively and cross-compiles just fine, but
fails to generate valid code on the Broadcom 1250. The
compiler does work, as I have got it to work just fine
on ix86 systems and it is the recommended Fortran 95
compiler by many organizations I've talked to.
Obviously, if you don't have to worry about Fortran,
this is a non-issue. For those who do, coaxing G95 to
behave with GCC 4.1.x will be an interesting problem.)


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
