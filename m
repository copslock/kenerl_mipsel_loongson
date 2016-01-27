Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Jan 2016 09:17:25 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35170 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009259AbcA0IRXx3Igp convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Jan 2016 09:17:23 +0100
Received: by mail-lb0-f180.google.com with SMTP id bc4so785092lbc.2
        for <linux-mips@linux-mips.org>; Wed, 27 Jan 2016 00:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XuXhUpqX+pXAzttbbg9QCWN1fkdPBD6hEMEo/erm+tU=;
        b=ko9hI5blzIlFZwydc3r1iHl0WoStKn+ShX81sVOkBjmgVnzqLM8WJ7EMVAVEGBCXiu
         ZDcyKJlSqlZg0MqoOANoyQTI/fWnetHEsystQXsQ6lCfycd2zvf7v1g6KHNABa6K7fbF
         GEwh9aoRtkXupUXI2ZeT1JhNjikitoSD7wczhqEUOIyRJM4dmud0LvOR+Y/15b08WilO
         DB028jxD6/c6LVgUEkGNzeaXoty5kG8vT5z5D89SBrv5Xd9YhZo+4DKgQD+Ctys9zQNf
         vBFv8Puq2c0ZzPrYCQSPNWtf0WAXC0k4gMqKvGXcsTO4Gbqf1HWntn/vFgm/Y5M6eN8Q
         z4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=XuXhUpqX+pXAzttbbg9QCWN1fkdPBD6hEMEo/erm+tU=;
        b=My5121x6cuhiKIFvVIoCJMeMNoGXHqxrB/qShVFi4UUqHgd8ppD6Pjz7CWiyuDXQEN
         O+zWVoLE/e1y85zfFSYCscXtLO4Lnw+Zjy1RX+ZIZCt+4cETQhWrjjigt3HTaamQCyAb
         MTG+kSRK3b+U7qTzEnN70Rg/Tj8IIcg46KpnRxcOV0svVKTopgbyFjXi1qSKoscys/wn
         Hvxo8AWgDZcKvEnqYOa0yF/IjT9a4ombkyy6RBpUVxJuFpJoWSPUWyUnKQktD5ViX+NL
         QKoTT8IBmkCYfTFzlSah++axwycp/pndYJhJbSzAZ5Xhy9DCm+8g5moefU8zRV1sm32+
         qWyw==
X-Gm-Message-State: AG10YOSlQMJEuwbTir0YM4mdDrCnKmqdIKItLOPT+ApgpnasL6Oj5cjTUm56drwNfBDmig==
X-Received: by 10.112.144.226 with SMTP id sp2mr8015407lbb.70.1453882638142;
        Wed, 27 Jan 2016 00:17:18 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id rd3sm669417lbb.2.2016.01.27.00.17.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jan 2016 00:17:17 -0800 (PST)
Date:   Wed, 27 Jan 2016 11:42:33 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org
Subject: Re: [RFC v3 12/14] devicetree: add Onion Corporation vendor id
Message-Id: <20160127114233.3ce022e7c111aca268fb8740@gmail.com>
In-Reply-To: <20160126211529.GA10291@rob-hp-laptop>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-13-git-send-email-antonynpavlov@gmail.com>
        <20160126211529.GA10291@rob-hp-laptop>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Tue, 26 Jan 2016 15:15:29 -0600
Rob Herring <robh@kernel.org> wrote:

> On Sat, Jan 23, 2016 at 11:17:29PM +0300, Antony Pavlov wrote:
> > Please see https://onion.io/contact for details.
> > 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: devicetree@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Is this the publishers of "The Onion"?

Hélas non!

  https://foursquare.com/v/the-onion/4ff5f6ae067d7fbeb9bbb3c5

> 
> Acked-by: Rob Herring <robh@kernel.org>


-- 
-- 
Best regards,
  Antony Pavlov
