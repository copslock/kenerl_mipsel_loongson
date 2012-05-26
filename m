Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 May 2012 15:47:46 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:57803 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901162Ab2EZNrk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 26 May 2012 15:47:40 +0200
Message-ID: <4FC0DEEC.8050204@openwrt.org>
Date:   Sat, 26 May 2012 15:47:24 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        spi-devel-general@lists.sourceforge.net,
        Thomas Langer <thomas.langer@lantiq.com>
Subject: Re: [PATCH V5 16/17] SPI: MIPS: lantiq: add FALCON spi driver
References: <1337521579-1597-1-git-send-email-blogic@openwrt.org> <20120525233845.BD93C3E0BD2@localhost>
In-Reply-To: <20120525233845.BD93C3E0BD2@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>


> What exactly does this mean?  How does it not support any other type
> of SPI peripheral?  SPI is a really simple protocol, so what is it
> about this hardware that prevents it being used with other SPI
> hardware?
>
> I see a big state machine that appears to interpret the messages and
> pretend to be an SPI slave instead of telling linux about the real
> device.  /me wonders if it should this instead be a block device
> driver?
>

Thomas will need to comment on this part

>> +static int falcon_sflash_prepare_xfer(struct spi_master *master)
>> +{
>> +	return 0;
>> +}
>> +
>> +static int falcon_sflash_unprepare_xfer(struct spi_master *master)
>> +{
>> +	return 0;
>> +}
> Don't use empty hooks.  Just leave them uninitialized.  The core will
> do the right thing.
>

I was under the impression that the need for these 2 callbacks was
removed in 3.5. As this patch flows via MIPS there would be a merge
order problem making the kernel non bisectable

I am a bit confused. You keep ack'ing this driver and then commenting on
it a few weeks later.... obsoleting the ACK ...
