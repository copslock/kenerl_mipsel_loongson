Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 11:19:07 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:37811 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492046AbZKIKTA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 11:19:00 +0100
Received: by ewy12 with SMTP id 12so3072631ewy.0
        for <multiple recipients>; Mon, 09 Nov 2009 02:18:54 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=Bdehhvvwjh/b1qpUWIwsJPX6TfclHr9L8bwu9eM05cY=;
        b=bP6tyiixDco59NvVjFDz7PXnroJPqflGwQ1ecGyn6uIxEHUmVSNXeCD5dD5uRFTo9A
         Gs2Va7KtQ0CSY5xOmd018AxvVk62HeA1THwDqd8muGX5bqvxG+6iG2wQEYdKhGyKKvQx
         Db8pqt6vQLErPemW6aZWH/+twatdhdztTATOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=Geo25+JrvqXJ0nxSezEoDp+Yb+GSGfnnCppyF8weqxivHHcqv9b5iIdu6EnQlLdRFi
         2dZZzYh36MrwogymrwECMTu/1NoZNEIWjUtOYOyCFwch0i6ps0E0oRl7H9jAQnLoHVia
         BRJc50y4nABPS1RAAIykJnwX3QLg7YS+rhBiA=
Received: by 10.213.23.206 with SMTP id s14mr8758677ebb.73.1257761934842;
        Mon, 09 Nov 2009 02:18:54 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id 28sm5797328eyg.14.2009.11.09.02.18.53
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 02:18:53 -0800 (PST)
From:	Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:	David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2 net-next-2.6] au1000-eth: convert to platform_driver model
Date:	Mon, 9 Nov 2009 11:18:05 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-14-server; KDE/4.3.2; x86_64; ; )
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	netdev@vger.kernel.org
References: <200911081542.12219.florian@openwrt.org> <20091108.210236.247950385.davem@davemloft.net>
In-Reply-To: <20091108.210236.247950385.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200911091118.05245.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi David, Ralf,

On Monday 09 November 2009 06:02:36 David Miller wrote:
> From: Florian Fainelli <florian@openwrt.org>
> Date: Sun, 8 Nov 2009 15:42:11 +0100
> 
> > This patch converts the au1000-eth driver to become a full
> > platform-driver as it ought to be. We now pass PHY-speficic
> > configurations through platform_data but for compatibility
> > the driver still assumes the default settings (search for PHY1 on
> > MAC0) when no platform_data is passed. Tested on my MTX-1 board.
> >
> > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> 
> Ralf, feel free to merge this yourself since it depends upon
> the previous Alchemy platform patch:
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thank you David. I will do a follow up patch which cleans up the driver once 
that one gets merged.
