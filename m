Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 14:19:40 +0200 (CEST)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:44830 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012115AbaJVMThfqs5a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 14:19:37 +0200
Received: by mail-ie0-f175.google.com with SMTP id at20so3302192iec.20
        for <linux-mips@linux-mips.org>; Wed, 22 Oct 2014 05:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8ZudfRSECAtxtqrTFseJYqvGiBQ1AbRz4UNuaDhDpow=;
        b=OzERVMLAXwgHepAP6br1MQPtV8C/8F6jb/zf/IvXTy7V5irDueMYKcrL2v6hs9AtXi
         zY2lYl2wlJGciY7k2w1way8Sm3OU08gTbYLc/DwN5WHKeoFHUNiT8dvyLWNnO+b5x2fK
         XJ234Rk/9UMWxWX3mIxdW3Kfcz8/fvrmXTz+kGE69V4P/f8pnpGkkpUUX1QiFsNOpOVW
         xMC/Mna9Vz4Mpu4eg4eyVkNC2s53G94qCY+FWuw52PoXvHUds4Tzf3ea86dB8w7yB89U
         +v9ZECgGTzTVtf9gTV3e9w05vRMjI1xcXRiPWsr7j0Hm3Tyn8/+R2EGySv7A67SZh8U9
         wi5w==
X-Gm-Message-State: ALoCoQlit3qBk88HiDVcTDmu6eZernxCu292wyW5ppAYEP+Ni0WILveRHgCO+aJS/9XNHd/j6mKZ
X-Received: by 10.107.164.71 with SMTP id n68mr3018207ioe.17.1413980371100;
        Wed, 22 Oct 2014 05:19:31 -0700 (PDT)
Received: from hash ([2001:470:1d:6db:230:48ff:fe9d:9c89])
        by mx.google.com with ESMTPSA id 93sm7438398iol.40.2014.10.22.05.19.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 22 Oct 2014 05:19:30 -0700 (PDT)
Received: from bob by hash with local (Exim 4.80)
        (envelope-from <me@bobcopeland.com>)
        id 1Xgurw-00054T-Q6; Wed, 22 Oct 2014 08:18:24 -0400
Date:   Wed, 22 Oct 2014 08:18:24 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Jiri Slaby <jirislaby@gmail.com>,
        Nick Kossifidis <mickflemm@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
        linux-wireless@vger.kernel.org, ath5k-devel@lists.ath5k.org
Subject: Re: [PATCH v2 11/13] ath5k: revert AHB bus support removing
Message-ID: <20141022121824.GA19113@localhost>
References: <1413932631-12866-1-git-send-email-ryazanov.s.a@gmail.com>
 <1413932631-12866-12-git-send-email-ryazanov.s.a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1413932631-12866-12-git-send-email-ryazanov.s.a@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <me@bobcopeland.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43481
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: me@bobcopeland.com
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

On Wed, Oct 22, 2014 at 03:03:49AM +0400, Sergey Ryazanov wrote:
> This reverts commit 093ec3c5337434f40d77c1af06c139da3e5ba6dc.
> 
> AHB bus code has been removed, since we did not have support Atheros
> AR231x SoC, required for building the AHB version of ath5k. Now that
> support WiSoC chips added we can restore functionality back.
> 
> Singed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
  ^^^^^^

Please keep the patches away from the stove! (SCNR)

-- 
Bob Copeland %% www.bobcopeland.com
