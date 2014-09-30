Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 15:52:20 +0200 (CEST)
Received: from mail-we0-f181.google.com ([74.125.82.181]:56653 "EHLO
        mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010180AbaI3NwSPNLq6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 15:52:18 +0200
Received: by mail-we0-f181.google.com with SMTP id u57so3542639wes.40
        for <multiple recipients>; Tue, 30 Sep 2014 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=uvMEGzIW9Xyv9R4Zkf/iFrY/FvXH3M1AHFTA4kOA5RA=;
        b=wxjqYI8sYZ1ArLe/y37CsMRvjxL890FwF/MrYwKCXAShdDRUSzfWjDp/utiIAFJOQD
         G7EkN6MzvB/3X5v7IiQodCSETwmehIrsrstIsz8q2/flfC2E/PYk0REk07YQJRttqE93
         CvOaAzNK86x0OB+wfjLN/J6QgynMhRONBlgVfaVsFUb64swV0gNyD0XK4jCk6+tu+/dG
         mo6qSTVndVaAbpSZQF9gHtPDQQ77/GY3ZlPvZP7XH+bx7y8JncyOWFkyMDrLV/c2CZYX
         PhMEOD6BwBs/JOV79ErYxwQlhcg3x4v1Cc2LXucIB1inIwkfz8D7Lh5V4Kgpx6YBBLI2
         x8AQ==
X-Received: by 10.194.177.226 with SMTP id ct2mr52118151wjc.20.1412085132953;
        Tue, 30 Sep 2014 06:52:12 -0700 (PDT)
Received: from [10.24.135.53] ([160.92.7.69])
        by mx.google.com with ESMTPSA id kx2sm19330378wjb.6.2014.09.30.06.52.11
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 30 Sep 2014 06:52:12 -0700 (PDT)
Message-ID: <1412085083.10205.8.camel@L80496>
Subject: Re: [PATCH] tc: fix warning and coding style
From:   Thibaut Robert <thibaut.robert@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Sep 2014 15:51:23 +0200
In-Reply-To: <CAMuHMdXj=b0G7foTRkcEtRC_De8+WjVefxBfW=s1sjaXLeF5nQ@mail.gmail.com>
References: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
         <CAMuHMdXj=b0G7foTRkcEtRC_De8+WjVefxBfW=s1sjaXLeF5nQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <thibaut.robert@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thibaut.robert@gmail.com
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

Hi Geert,

Le mardi 30 septembre 2014 à 14:28 +0200, Geert Uytterhoeven a écrit :
> Hi Thibaut,
> 
> On Tue, Sep 30, 2014 at 2:16 PM, Thibaut Robert
> <thibaut.robert@gmail.com> wrote:
> > Fix gcc warning:
> > warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘resource_size_t’ [-Wformat=]
> >
> > As resource_size_t can be 32 or 64 bits (depending on CONFIG_RESOURCES_64BIT), this patch uses "%lld" format along with a cast to u64 for printing resource_size_t values
> 
> Please use %pR instead (cfr. Documentation/printk-formats.txt).

This code use 'resource_size_t' but I think %pR is for 'struct resource'. I got inspired by this patch: https://lkml.org/lkml/2008/8/29/187 

However, I've thought again, and '%u' is probably enough for displaying a size in MiB. So I propose the following :
(Parens around the cast were also missing in my first patch):

@@ -117,10 +114,10 @@ static void __init tc_bus_add_devices(struct tc_bus *tbus)
 			tdev->resource.start = extslotaddr;
 			tdev->resource.end = extslotaddr + devsize - 1;
 		} else {
-			printk(KERN_ERR "%s: Cannot provide slot space "
-			       "(%dMiB required, up to %dMiB supported)\n",
-			       dev_name(&tdev->dev), devsize >> 20,
-			       max(slotsize, extslotsize) >> 20);
+			dev_err(&tdev->dev,
+				"Cannot provide slot space (%uMiB required, up to %uMiB supported)\n",
+				(unsigned int) (devsize >> 20),
+				(unsigned int) (max(slotsize, extslotsize) >> 20));
 			kfree(tdev);
 			goto out_err;
 		}


WDYT ?

Thibaut
