Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jun 2011 11:01:35 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:51881 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491072Ab1FVJBc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Jun 2011 11:01:32 +0200
Received: by ewy3 with SMTP id 3so180604ewy.36
        for <linux-mips@linux-mips.org>; Wed, 22 Jun 2011 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:organization:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=yPr7wQ2xsEQM8HttdQesEQB27gWM3L6WJSLO/zLCkSg=;
        b=KFarHnTos6OSuyWDo2VKY1Jg8IQl1sNpFI3xhBzCuLuDfuPpM+8Id7AwPNQGqEvtkc
         J46wauPkBcoRo89GgqN8VXS0Dx2JCqj5kZN5ans09vu8OBkzTHPm3Vqg9mlNUDyDy0pJ
         AgNrhCi/7KNIvyo2zAtwugNjh99TOcuE7fPBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=x2m3Nt4dyrDDRNs6A0uXR8+C4P2E9jlXA7KlAA317du+IejQCPt0dXCU0odIWZ+Twy
         l9eidl4Zk6zrkKAQDn2deHj5Z/RmoRXxVEhhMbeZxoz4VLqiWFs9uCrqhHbxEks6m9np
         vpvzET6N7Kyt84b3S6C3HRKVbLIk1Qtd7uXuo=
Received: by 10.14.48.75 with SMTP id u51mr309681eeb.154.1308733287117;
        Wed, 22 Jun 2011 02:01:27 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id p78sm298948eep.12.2011.06.22.02.01.25
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 02:01:25 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 1/5 v3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
Date:   Wed, 22 Jun 2011 11:05:40 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-server; KDE/4.6.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Jamie Iles <jamie@jamieiles.com>
References: <201106151915.09729.florian@openwrt.org> <201106221024.20485.florian@openwrt.org> <20110622085809.GS23305@infomag.iguana.be>
In-Reply-To: <20110622085809.GS23305@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106221105.40343.florian@openwrt.org>
X-archive-position: 30492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17943

Hello Wim,

On Wednesday 22 June 2011 10:58:09 Wim Van Sebroeck wrote:
> Hi Florian,
> 
> > On Wednesday 15 June 2011 19:15:09 Florian Fainelli wrote:
> > > Signed-off-by: Florian Fainelli <florian@openwrt.org>
> > > ---
> > > No changes in v1, v2 and v3
> > 
> > Wim, these are mostly fixes for the driver, do you prefer they get merged
> > with the MIPS tree?
> 
> No, I had them in linux-2.6-watchdog-next since this weekend allready and
> was planning to sent the fixes upstream. But I think I fotgot to e-mail
> about it. :-(

No problem, thanks for the heads up.
--
Florian
