Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Dec 2017 01:44:30 +0100 (CET)
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46717 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992396AbdLMAoWi0-pl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Dec 2017 01:44:22 +0100
Received: by mail-ot0-f193.google.com with SMTP id j2so613121ota.13;
        Tue, 12 Dec 2017 16:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6faOQ5U31s7b+ZEe9ON1PRgT9gs9DL5WFjZzQhPa5Bk=;
        b=K0goK2qQ40cU6rqXfjdcLjc4aGajmqJYyZXpxDsYbhzGzLIoAxMaoy3NwaYvcCcdBf
         avy7NFfElne3woP6v7UALeoKkxa+MOyTF90WwVir9iGwxcd9Mr5fKEbno2cFO7C6ajLg
         jK9rTnZGITujFJ4Hp44AYebXg4i5D7k7KhKCQLrwsFqzL2r2c+CrN/kYWhclB1BIU4XC
         WvUq5XK+XP5jYJbBQ0by3ZngfSDeTvnQ8bavV+n7MTbwqT6yQhukY0p5ekh6O/vyz76E
         JjoAjWs2nTaYv3ld095cOf4ut5zIGaWRmOSfjl91VNBPuiqrD6a0C4W0dTpNfLP0c5/a
         6dig==
X-Gm-Message-State: AKGB3mJWdO7WPtRZT4hV+UzbCu5DGJBRzwFjUON3U79+do6FcoYoqu23
        18TXSk2g+6CkIjrCxhQsYQ==
X-Google-Smtp-Source: ACJfBovbTVzKtUNcD05FL+G3KrogCXW1j0Rzn4TIgXp0wQmuNHvb2kNRawGHftDxdL6BbtfU+EzQXg==
X-Received: by 10.157.19.45 with SMTP id f42mr633536ote.4.1513125856387;
        Tue, 12 Dec 2017 16:44:16 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id y51sm269390oti.9.2017.12.12.16.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Dec 2017 16:44:15 -0800 (PST)
Date:   Tue, 12 Dec 2017 18:44:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/13] dt-bindings: mips: Add bindings for Microsemi
 SoCs
Message-ID: <20171213004415.l7cz5b2jj3vwzvsw@rob-hp-laptop>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-7-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208154618.20105-7-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Dec 08, 2017 at 04:46:11PM +0100, Alexandre Belloni wrote:
> Add bindings for Microsemi SoCs. Currently only Ocelot is supported.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/mips/mscc.txt | 46 +++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/mscc.txt

Reviewed-by: Rob Herring <robh@kernel.org>
