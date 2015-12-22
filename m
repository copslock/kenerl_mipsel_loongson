Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 22:22:40 +0100 (CET)
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33562 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014376AbbLVVWhvmbiD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 22:22:37 +0100
Received: by mail-pf0-f181.google.com with SMTP id q63so5919379pfb.0
        for <linux-mips@linux-mips.org>; Tue, 22 Dec 2015 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fQGC1z8rXhZfT+Xif9JMiPn1kcoRgNiRpp+gV5tHqqA=;
        b=saJInhbyogsSiTn4yIoa/Qq/WS68M9XPT2nHzPIcN6mW+Gr5VdeDf1s9a8+Je5y7Sm
         mr5EMukLB0kO9NAbG64xUhkZtw04rjFJaJgVAmSioSNQuqlX8DPjQqapccpECkPyNGwu
         Li6OPmq45dZcMCVrUdcwKzheYGvk3cn7G43iee7Iwek/PwtvCPhyKOGE0mk+VDyq9Dnt
         jljaufdV3Hd/ADmTLCa0uNuuJN9FNRAKjXIpSl7Q7qLkt/f2syVGeo6aQxeOwz3xMIop
         IgOYNsXYP0AJzMTHaXKnAxPmJS9q2d+CGycGgXX4f5RrSjXCjAYhXJtTfddvZ8Lis99X
         Fd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fQGC1z8rXhZfT+Xif9JMiPn1kcoRgNiRpp+gV5tHqqA=;
        b=GgxH1nwGXjtQgKgYVxWxgzgCpHDGdmjaeQgqUWSbPuJwxJdMGMboF66klqYY2UVBYb
         hlOQsoGBy5a124i3qStPDvp1kIrq6w+QbRNfO3tgzkigWayxMcFF+J4wgFt77cbrmnNg
         EcTbwkFXwa8k1bb2q1f10Cp7+PX0LdogA9JzJ1SGVt6CnooFGKeKZjZv1ZDvMENSYeja
         5FmN9xjEOhvoEtCrVqfaWOXQB9+7MVRuuqkU0W/RFoRo3xSejsM8OMT9siIprBm1qdPA
         SyIyMZNwWeqEOVzAK9/B36Z/Y1TYScwtdxvgcRnd2cjtmiWoRFHdfbDS9D/Fks3D1p5G
         FsXA==
X-Gm-Message-State: ALoCoQl5gHj37e7H5PgT3jpM2hLllBc7Rul832jipj78pqFFYEbUXbnGqSclyqr0Jto6XZddwkGhPQAybfyqt0/M1EPzHpPITw==
X-Received: by 10.98.16.70 with SMTP id y67mr16472950pfi.150.1450819351556;
        Tue, 22 Dec 2015 13:22:31 -0800 (PST)
Received: from localhost ([2620:0:1000:fd1f:a01d:b55d:7883:cc13])
        by smtp.gmail.com with ESMTPSA id 19sm7078441pfj.16.2015.12.22.13.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 13:22:30 -0800 (PST)
Date:   Tue, 22 Dec 2015 13:22:25 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>, arm@kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] ARM: mvebu: ix4-300d: Add compatible property to
 "partitions" node
Message-ID: <20151222212225.GE30172@localhost>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <1450694033-27717-2-git-send-email-geert+renesas@glider.be>
 <87zix3rbm7.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zix3rbm7.fsf@free-electrons.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <olof@lixom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: olof@lixom.net
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

On Mon, Dec 21, 2015 at 05:48:48PM +0100, Gregory CLEMENT wrote:
> Hi Geert,
>  
>  On lun., d??c. 21 2015, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> > As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> > property to "partitions" node"), the "partitions" subnode of an SPI
> > FLASH device node must have a compatible property. The partitions are no
> > longer detected if it is not present.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Brian Norris <computersforpeace@gmail.com>
> 
> Applied on mvebu/dt (with the hope that it is still time to push it to
> arm-soc)

I think we should just take this directly, so feel free to drop it. I'll
followup on 0/9.


-Olof
