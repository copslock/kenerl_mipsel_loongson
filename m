Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2010 13:44:03 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:53333 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492401Ab0F1LoA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jun 2010 13:44:00 +0200
Received: by bwz20 with SMTP id 20so808031bwz.36
        for <multiple recipients>; Mon, 28 Jun 2010 04:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=aXYPty3O7ZzXSG7SeD9ju4Q0BMb1OVfik3/hfzj/muk=;
        b=dXsMjDeyIWM3crDFbwimuU2TsXe3wDlZg3TFUSvAyvp9DW53RzNuYvadVVUkTrWeAu
         lwtAHks7o5V/qhLgn0fWXK/6W2z7a02KEBo7T7jr/RLfUt3OAyKqNR5KFTXmdZfhgAqX
         /s/lwnMBdK6NE0OabkrhGgrlo7USfF/tzuorc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rZfDOLcJnB6EfC1Ct3xseHI0uknAy0RgJd76UJ0WFwUbev6KG9Ofb3UXdwWdEaYLZu
         6B0UvZO6xwp6F7U/9YogSIXohrw2MPKraGYZg7Q6lMOvhYAE3SrclScpCSGYmt0dhUf4
         I7XyyTzX2i+zJVdBZZ/tnhke3dicMVFoG5xyY=
Received: by 10.204.47.34 with SMTP id l34mr3476463bkf.77.1277725438935;
        Mon, 28 Jun 2010 04:43:58 -0700 (PDT)
Received: from localhost (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id u3sm18227429bkz.12.2010.06.28.04.43.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Jun 2010 04:43:56 -0700 (PDT)
Date:   Mon, 28 Jun 2010 15:43:54 +0400
From:   Anton Vorontsov <cbouatmailru@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2 24/26] power: Add JZ4740 battery driver.
Message-ID: <20100628114354.GA21096@oksana.dev.rtsoft.ru>
References: <1276924111-11158-1-git-send-email-lars@metafoo.de>
 <1276924111-11158-25-git-send-email-lars@metafoo.de>
 <4C26B05C.3030706@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C26B05C.3030706@metafoo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cbouatmailru@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18540

On Sun, Jun 27, 2010 at 03:58:52AM +0200, Lars-Peter Clausen wrote:
> Hi Anton
> 
> You already said that v1 of the patch looked good to you. There are some minor
> modifications in v2 due to code re-factoring of the ADC driver. If you think this
> version is good as well an Acked-By would be nice :)

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks,

> Lars-Peter Clausen wrote:
> > This patch adds support for the battery voltage measurement part of the JZ4740
> > ADC unit.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Anton Vorontsov <cbouatmailru@gmail.com>
> > 
> > ---
> > Changes since v1
> > - Fix voltage difference check in jz_update_battery
> > - Move get_battery_voltage from the hwmon driver to the battery driver
> > - The battery driver is now a cell of the ADC MFD driver
> > ---

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
