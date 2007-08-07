Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 14:10:11 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:29153 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20024218AbXHGNKD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2007 14:10:03 +0100
Received: from anguille.univ-lyon1.fr ([134.214.4.207])
	by hall.aurel32.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1IIOov-0003Oh-JR; Tue, 07 Aug 2007 15:09:57 +0200
Message-ID: <46B86F1E.6060206@aurel32.net>
Date:	Tue, 07 Aug 2007 15:09:50 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 0/4] MIPS BCM947xx CPUs support
References: <20070806150701.GE24308@hall.aurel32.net> <20070807125521.GA23739@linux-mips.org>
In-Reply-To: <20070807125521.GA23739@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Ralf Baechle a écrit :
> On Mon, Aug 06, 2007 at 05:07:01PM +0200, Aurelien Jarno wrote:
> 
>> The following series of patches add basic support for the BCM947xx 
>> CPUs. CFE support still needs work and thus is not included in those 
>> patches, so the command line has to be included in the kernel. 
>> Everything else is fully functional and the resulting kernel works
>> fine on a Netgear WGT634U.
> 
> Any reason why not to simply share the CFE related code with what the
> Broadcom Sibyte family of chips are using?

That's actually the plan, but there is some work to do before. BCM947xx
CFE code is too BCM947xx centric, and the one in the sibyte/cfe
directory is too SiByte centric. For example the SiByte code assume that
the environment variables are in a serial EEPROM, whereas the BCM947xx
code assumes that it is in the FLASH.

Merging both will take some time, and if we accept to not get the kernel
parameters from CFE, it is possible to run BCM947xx board with these
patches.

>> I am submitting those patches for inclusion into -mm as they depend
>> on features that are not present in the linux-mips git tree, but are
>> present in the -mm series, namely Sonic Silicon Backplane bus support.
> 
> That won't fly as akpm is pulling from the MIPS tree also, so there
> will be conflicts really soon.
> 

I don't see a patch corresponding to the MIPS tree in the broken-out
directory. Anyway what other solution do you propose? I can see:
- Integrate the patches that have the most risk of conflicts (I think
patch #1) into the MIPS tree.
- Integrate all BCM947xx patches into the MIPS tree accepting that it
can compile without additional patches.
- Integrate SSB patches into the MIPS tree.

Aurelien

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
