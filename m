Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 13:00:36 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:33877 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492533AbZKKMAa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Nov 2009 13:00:30 +0100
Received: by bwz21 with SMTP id 21so898505bwz.24
        for <multiple recipients>; Wed, 11 Nov 2009 04:00:24 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xhDsuggz8gfbg+oOfndCMUf5lIsV2AJrEQ+/saqzilQ=;
        b=AX8qJfpBgaGuPyFUlhkLV/ZbjafzUkjSk90ys4wlv9PKw0V9KDK2TfLkrp88dgqsOZ
         O8Pq3vRepTS5Mzx+pOpolQy5PDdOieDXjEUZ0J9zcviR43AuH0RNsMBBS50h9eXfb+cR
         mp3pNYYaLIBl6M3q06RxBLNpYWFqD3Z53MEcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Oj6GAGqAwQAQLd747CCJEwf0SVtBjg31j7GRujzPk9KYYhv4Hzuqekx0i5UnvIci4j
         UfGlIGgwAqN/KRiMp6OGbyEFgkXNp7N5FnmqMtLwWNAvKDLn6Yl3FjSSzSlvuYa7ewu/
         p25DXpto+k4mxwd+hkAIx3VexfF3BCDTybbrI=
MIME-Version: 1.0
Received: by 10.102.236.29 with SMTP id j29mr531749muh.68.1257940823871; Wed, 
	11 Nov 2009 04:00:23 -0800 (PST)
In-Reply-To: <200911111254.16500.florian@openwrt.org>
References: <200911100113.38685.florian@openwrt.org>
	 <f861ec6f0911100120j12d86b0cs3ef9c2816019eaf9@mail.gmail.com>
	 <200911111254.16500.florian@openwrt.org>
Date:	Wed, 11 Nov 2009 13:00:23 +0100
Message-ID: <f861ec6f0911110400g105e6a2j3666f32c7cb7bc85@mail.gmail.com>
Subject: Re: [PATCH 2/2] au1000-eth: convert to platform_driver model
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 12:54 PM, Florian Fainelli <florian@openwrt.org> wrote:
> Hi Manuel,
>
> On Tuesday 10 November 2009 10:20:25 Manuel Lauss wrote:
>> Hi Florian,
>>
>> On Tue, Nov 10, 2009 at 1:13 AM, Florian Fainelli <florian@openwrt.org>
> wrote:
>> > This patch converts the au1000-eth driver to become a full
>> > platform-driver as it ought to be. We now pass PHY-speficic
>> > configurations through platform_data but for compatibility
>> > the driver still assumes the default settings (search for PHY1 on
>> > MAC0) when no platform_data is passed. Tested on my MTX-1 board.
> [snip]
>> >
>> > -                       phydev = tmp_phydev;
>> > -                       break; /* found it */
>> > +               if (aup->phy1_search_mac0) {
>> > +                       /* try harder to find a PHY */
>> > +                       if (!phydev && (aup->mac_id == 1)) {
>> > +                               /* no PHY found, maybe we have a dual
>> > PHY? */ +                               printk (KERN_INFO DRV_NAME ": no
>> > PHY found on MAC1, " +                                       "let's see
>> > if it's attached to MAC0...\n"); +
>> > +                               /* find the first (lowest address)
>> > non-attached PHY on +                                * the MAC0 MII bus
>> > */
>> > +                               for (phy_addr = 0; phy_addr <
>> > PHY_MAX_ADDR; phy_addr++) { +                                       if
>> > (aup->mac_id == 1)
>> > +                                               break;
>>
>> aup->mac_id needs to be 1 for this loop to be executed in the first
>> place, and here
>> you immediately bail out if it is.
>
> From the reading of the comment, it seems to me like we should not do anything
> in this for loop if we were using MAC1, but I may have misunderstood that, as
> such I have added this break to "comply" with the comment.
>
>> Also, how do you access the phy map of the other controller without use of
>>  the au_macs[] structure? (which is unused after this patch and could be
>>  removed, along
>> with the NUM_ETH_INTERFACES constant)
>
> We access the phy map of the other controller by using the correct mii bus
> identifier, since we have registered a per-interface mdio bus or have I
> overlooked something ?

Don't know, that's why I asked.


>>
>> > +                                       struct phy_device *const
>> > tmp_phydev = +
>> > aup->mii_bus->phy_map[phy_addr];
>>
>> My compiler complains about mixed code/declarations.
>
> That declaration was already there and as this patch has no intent to clean
> anything right now, I have left it as-is.

The "if (aup->mac_id == 1)" you inserted before it causes it.

You're right though in that there's some cleanup potential after this
patch has gone in...

      Manuel Lauss
