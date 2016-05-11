Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 17:44:41 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:57100 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028618AbcEKPojBt-Fz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 17:44:39 +0200
Received: from ohm.aurel32.net ([2001:bc8:30d7:111::1000])
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <aurelien@aurel32.net>)
        id 1b0WJR-0002oa-1j; Wed, 11 May 2016 17:44:37 +0200
Received: from aurel32 by ohm.aurel32.net with local (Exim 4.87)
        (envelope-from <aurelien@aurel32.net>)
        id 1b0WJN-0002Lo-F1; Wed, 11 May 2016 17:44:33 +0200
Date:   Wed, 11 May 2016 17:44:33 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] MIPS: Octeon: byteswap initramfs in little endian mode
Message-ID: <20160511154433.GA15079@aurel32.net>
Mail-Followup-To: David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>
References: <1462484017-29988-1-git-send-email-aurelien@aurel32.net>
 <572BBDB8.8000300@caviumnetworks.com>
 <20160505221649.GA29979@aurel32.net>
 <572BCECE.7040600@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <572BCECE.7040600@caviumnetworks.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

[ I have just realized this mail was never sent. Doing it now so that it
can given a bit of context for the v2 ]

On 2016-05-05 15:53, David Daney wrote:
> 
> 
> On 05/05/2016 03:16 PM, Aurelien Jarno wrote:
> > On 2016-05-05 14:40, David Daney wrote:
> > > On 05/05/2016 02:33 PM, Aurelien Jarno wrote:
> > > > The initramfs if loaded in memory by U-Boot running in big endian mode.
> > > > When the kernel is running in little endian mode, we need to byteswap it
> > > > as it is accessed byte by byte.
> > > 
> > > Ouch!
> > > 
> > > Really it should be fixed in the bootloader, but that probably won't happen.
> > 
> > How would you see that fixed in the bootloader? I doubt it's difficult
> > to autodetect that, as the initramfs is basically loaded in memory
> > first, and later only the address and size are passed on the kernel
> > command line using the rd_start= and rd_size= options.
> > 
> > The other alternative would be to provide reversed endian fatload,
> > ext2load, ext4load, ... versions. Or maybe a better alternative would be
> > a function to byteswap a memory area, it could be inserted in a bootcmd
> > between the load and the bootoctlinux.
> 
> The easiest thing might be to byteswap it before u-boot ever gets involved,
> and leave the kernel alone.

I guess you basically mean in userland when generating the initramfs. It
means that we have to store the initramfs byte swapped on the hard
drive. It will break standard tools which might try to access it (e.g.
lsinitramfs).

In addition to that it will also breaks kexec, which will be run in
little endian mode. This is also a reason to not always byte swap the
initramfs in the kernel.

> > 
> > > I wonder, is there a magic number that the initrd has?  If so, we could
> > > probe for a byteswapped initrd and not do the byte reversal unconditionally.
> > 
> > There is a magic number... after it has been uncompressed. The magics
> > for the compressed version are defined in lib/decompress.c. Maybe we can
> > call decompress_method() from the finalize_initrd with the first 8 bytes
> > byteswapped and check for the result.
> 
> I guess you could look for magic numbers of the supported compression
> protocols (gzip, xz, etc), but that could be error prone.
> 
> I don't really object to the original patch, but was just trying to consider
> alternatives.

I have just sent a patch which does that.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
