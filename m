Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33IEEx13511
	for linux-mips-outgoing; Tue, 3 Apr 2001 11:14:14 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33IEDM13508
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 11:14:13 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id NAA17400
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 13:14:12 -0500
Message-ID: <3ACA07F6.CB1119A4@cotw.com>
Date: Tue, 03 Apr 2001 12:27:18 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <3AC90E16.AEF59359@cotw.com> <20010403041740.G5099@rembrandt.csv.ica.uni-stuttgart.de> <20010403102608.A30531@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> IRIX ELF orders the symbol table of object files in a way that violates
> the ABI.  Worse, these IRIX specialities are not documented anywhere.
> 
> Changing to ABI ELF only makes them look as they're supposed to ...
> 
Thanks for backing me up. Also, after discussion with Ralf on IRC,
the decision has been made to except the patch as the fix. There will
not be an additional target 'irix[little|big]mips' added. Linux and
SVR4 will utilize 'trad[little|big]mips' and IRIX and other targets
will use '[little|big]mips'. Also, when building for Linux targets,
the 'elf[32|64]_[little|big]mips' targets (IRIX) will not be built as
emulation targets.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
