Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jun 2009 22:39:51 +0200 (CEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:53449 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492426AbZFWUjo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Jun 2009 22:39:44 +0200
Received: by fxm23 with SMTP id 23so392488fxm.0
        for <multiple recipients>; Tue, 23 Jun 2009 13:36:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=dRaSlgoqN9d+u28pJtjlIq3eaEBIz/0tMjlRNGnrDlg=;
        b=A7bug1nuC4i8YdCb8rnoTS2AMbf/ddBXVH2pnIvq7XcRA9UrUWeziNBIsZzgVjssXu
         zfwS5vyRaUD23cGI9T0GQ1nKPZSx1CdBq8BTCXTftanWenXnvXUvOLKVnoTuqsT2E8/h
         8GqIN0OILqRGtf/bIKGw9aJttIoCJ3Jkbvips=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HE/wLpPpw73Hcp2bsUT96G+c05S279G5Vc9XJeYBuidOfQYhLa8ox8zgIBhoxA5xgE
         4JQtObcarUcZ7jGgS2lzl+s65lOw+A7F3lTbPaqbCTZoVqRBjeVKT/RctPM/NMFg9EWG
         Bw/JSzTiIZ0nMmuKiglPIVccWg12MO0MeESJQ=
Received: by 10.103.222.1 with SMTP id z1mr218294muq.44.1245789386610;
        Tue, 23 Jun 2009 13:36:26 -0700 (PDT)
Received: from flowlan.maisel.int-evry.fr ([157.159.47.25])
        by mx.google.com with ESMTPS id e10sm1701046muf.44.2009.06.23.13.36.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Jun 2009 13:36:26 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	David Daney <ddaney@caviumnetworks.com>
Subject: Re: [PATCH] Staging: octeon-ethernet: Convert to use net_device_ops.
Date:	Tue, 23 Jun 2009 22:36:24 +0200
User-Agent: KMail/1.9.9
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
References: <1245782048-24058-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1245782048-24058-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200906232236.24718.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi David.

Le Tuesday 23 June 2009 20:34:08 David Daney, vous avez écrit :
> Convert the driver to use net_device_ops as it is now mandatory.
>
> Also compensate for the removal of struct sk_buff's dst field.
>
> The changes are mostly mechanical, the content of ethernet-common.c
> was moved to ethernet.c and ethernet-common.{c,h} are removed.

Thanks for doing that. It works just fine on my eval board.

>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Tested-by: Florian Fainelli <florian@openwrt.org>

-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
