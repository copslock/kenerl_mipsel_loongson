Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 10:19:14 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:55542 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab1EPITL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 10:19:11 +0200
Received: by wwb17 with SMTP id 17so3972173wwb.24
        for <linux-mips@linux-mips.org>; Mon, 16 May 2011 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=DrEZhMyg6rALu3vOMThwremp8AAWirleT6TeRj1kT5U=;
        b=IdUdWKj8H/c2xL1CQTqXKyTjDhVQoFDmptSq/Ariqgg3uC42KAGQfyq8wUovYtBThy
         qY0tf24HxrIDex/O3xolGBaFY5UMxmWr5DNW21mC0EosHRVOxMqThl7k+mND3/6J76x4
         MhKs+dizAlflRX33w0wq5GFry49lxU47wNI6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=dJJXofSz9JJe6VAntaQ0zJIxQsOgmnl22oOCMtazCw2rFwCO3IbDTlgfaAA2Aypm2E
         PqYRcVS44+JbhIulKhK9sUIxQjUn0yj9M8xvaC5zY1Hq66I+lFT36AtxdLe3xT2kV3vH
         Bm/TksXFQHA+8T7MVju3MxR/scuUTvJtbY1IQ=
Received: by 10.227.55.6 with SMTP id s6mr3979509wbg.112.1305533945733;
        Mon, 16 May 2011 01:19:05 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id s20sm2983152wbh.6.2011.05.16.01.19.03
        (version=SSLv3 cipher=OTHER);
        Mon, 16 May 2011 01:19:03 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: reference to non-existent CONFIG_HAVE_GPIO_LIB variable?
Date:   Mon, 16 May 2011 10:23:33 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org
References: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.00.1105141904410.13343@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201105161023.33072.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello,

On Sunday 15 May 2011 01:05:58 Robert P. J. Day wrote:
>   the current kernel source contains a Makefile reference to the above
> Kconfig variable that does not appear to be defined anywhere.

It would help if you mention which Makefile references this Kconfig variable 
along with the changeset which introduced it.
--
Florian
