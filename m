Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Aug 2003 13:09:03 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:37461
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224821AbTHJMIy>; Sun, 10 Aug 2003 13:08:54 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19lp08-0001pF-00; Sun, 10 Aug 2003 14:08:44 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19lp08-0001XR-00; Sun, 10 Aug 2003 14:08:44 +0200
Date: Sun, 10 Aug 2003 14:08:44 +0200
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: load/store address overflow on binutils 2.14
Message-ID: <20030810120844.GB22977@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030807231518.GH3759@rembrandt.csv.ica.uni-stuttgart.de> <20030808.101102.71082885.nemoto@toshiba-tops.co.jp> <20030808030705.GJ3759@rembrandt.csv.ica.uni-stuttgart.de> <20030809.000603.74756723.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809.000603.74756723.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3010
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> >>>>> On Fri, 8 Aug 2003 05:07:05 +0200, Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> said:
> >> The b.S is just one line "lw $2, 0x80000000".
> Thiemo> Using 0xffffffff80000000 is a really ugly workaround for it.
> Thiemo> Seems like the constant isn't properly sign-extended inernally
> Thiemo> by the assembler.
> 
> Yes the workaround works.  But I modified binutils (just remove the
> checking code) instead of changing many constant definitions in my
> programs.  For now it is enough for me.  Thank you.

It is probably not a real binutils bug, but related to gcc mishandling
'unsigned long long'. The simple testcase

int main(void)
{
        unsigned long long a = 0;

        printf("%016x\n", ~a);

        return 0;
}

outputs

00000000ffffffff

on my i386-linux system. On mips-linux it's even worse, the result is

000000000000000b

If this is really an arch-independent problem, any (cross-)compile on
a 32bit system for 64bit BFD can be broken.


Thiemo
