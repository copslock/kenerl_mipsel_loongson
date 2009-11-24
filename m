Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 12:31:43 +0100 (CET)
Received: from mail-ew0-f212.google.com ([209.85.219.212]:63552 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1492291AbZKXLbh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 12:31:37 +0100
Received: by ewy4 with SMTP id 4so3097989ewy.27
        for <multiple recipients>; Tue, 24 Nov 2009 03:31:28 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=8+GC1d5vL/e5j2IwDksrSW5T7y0kB9HR+YLZD68FCJc=;
        b=Iuqw1nhTe+LpqfJwl8Tnf/qtH6IaM6E5awMacLFpm+WeM2bJ3lxm/IK+tq9axWP2Cy
         ZaP8f8n/4/tsO5ZoeH5xqL5fAU1NqVLLOsosoBExeEXGcObZOg8x8hy8OCUoe4Vu2kjW
         OXp0X9kQXgSsojg++6TNlGeIduD5cJnh1hb2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=E/r6QiN3reCbBBd8oLGJeZhujH49ltWHTl608nKHSxLqgki4hsSrtONIqa5YoOhJ0M
         qnhv8BRXKnvEEvqUBx4w031NCsmk6Uq8sdKKSkSc58igapzbx6n+ix0rU9mr5napZikS
         qVXw6m81IzwlUIais8wFj9kVHVT4aqVjoZuhE=
Received: by 10.213.97.30 with SMTP id j30mr4817753ebn.94.1259062285266;
        Tue, 24 Nov 2009 03:31:25 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 15sm214676ewy.8.2009.11.24.03.31.23
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Nov 2009 03:31:23 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:	David Miller <davem@davemloft.net>
Subject: Re: linux-next: manual merge of the mips tree with the net-current tree
Date:	Tue, 24 Nov 2009 12:30:22 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-14-server; KDE/4.3.2; x86_64; ; )
Cc:	ralf@linux-mips.org, sfr@canb.auug.org.au,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	a.beregalov@gmail.com, linux-mips@linux-mips.org,
	manuel.lauss@googlemail.com
References: <20091124113717.c5d86d41.sfr@canb.auug.org.au> <20091124011958.GA8105@linux-mips.org> <20091123.194343.232255103.davem@davemloft.net>
In-Reply-To: <20091123.194343.232255103.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911241230.22370.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25089
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

On Tuesday 24 November 2009 04:43:43 David Miller wrote:
> From: Ralf Baechle <ralf@linux-mips.org>
> Date: Tue, 24 Nov 2009 01:19:58 +0000
> 
> > On Tue, Nov 24, 2009 at 11:37:17AM +1100, Stephen Rothwell wrote:
> >> Hi Ralf,
> >>
> >> Today's linux-next merge of the mips tree got a conflict in
> >> drivers/net/au1000_eth.c between commit
> >> 63edaf647607795a065e6956a79c47f500dc8447 ("Au1x00: fix crash when trying
> >> register_netdev()") from the net-current tree and commit
> >> 6cdbc95856e7f4ab4e7b2f2bdab5c3844537ad83 ("NET: au1000-eth: convert to
> >> platform_driver model") from the mips tree.
> >>
> >> It looks to me that the mips tree change supercedes the net-current one
> >> (since it moves the register_netdev() call much later), so I just used
> >> this file from the mips tree.
> >
> > I agree.  David, can you just drop the net-current patch then?  This fix
> > is still needed for -stable however.
> 
> Why would I do that?  The bug fix is necessary for 2.6.32 too.

Ok, it is, but the platform_driver conversion patch is heavier, so the bugfix 
is way easier to apply on thom of the conversion.
--
WBR, Florian
