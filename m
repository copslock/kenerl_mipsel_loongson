Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 06:05:42 +0200 (CEST)
Received: from mail-pb0-f54.google.com ([209.85.160.54]:62137 "EHLO
        mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823059Ab3DPEFlCxZ2R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Apr 2013 06:05:41 +0200
Received: by mail-pb0-f54.google.com with SMTP id xa7so53977pbc.41
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 21:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Nqj+TI7sqwr03PzMfvEKFXqSTu3VH6W/Ku4EF7ubG+0=;
        b=OGT/X3VcYOMZ88LFXm25g6DQ4VrFtd1t0ItluCMOB0WO+Mf+3aywoVdhyvsK56xXDZ
         gwfFOgRq+yXW12DJzk2N8gLAUEGhyIc3aNelIToUj5iJMQCsHe2W4W56w3ydYvOeU2ow
         L8RxH3NPOZQzu9YSCq/T3Dek+XW3d+JNsVEFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=Nqj+TI7sqwr03PzMfvEKFXqSTu3VH6W/Ku4EF7ubG+0=;
        b=fc0RCndsImNixOxe5fvVpd5tkCjwhrGEEfvra4VYwuH+UKPpJnuseXE36DnxKWb+jF
         TQAUQe9GX6dUfamFvfOUcKJkvBcp2n+4FMkBHwNAI04ch/jyeHIAUINCrfJHshCjDT+q
         1S4fH1oYkoA20liU+AXsqDn0navh6HnIX9/n8rB3FW3o4bNf0P0ISHjSF07H9EIjW/xO
         v9spcbTFicOODKWuqmsfggDYp2CNS7c7/WgWpg45E5RWYg9+LPt23pCW+WKloJdu9zU+
         rPvcWUwOiZUFYyPNxoiTOA3jOIQR25tskjOZQ8OpNbQ+ZQgM/XT3xnoMOAhI6LPmMNcB
         QLwQ==
X-Received: by 10.66.21.38 with SMTP id s6mr1252966pae.103.1366085134333;
        Mon, 15 Apr 2013 21:05:34 -0700 (PDT)
Received: from localhost ([69.38.217.3])
        by mx.google.com with ESMTPS id jw10sm344446pbb.3.2013.04.15.21.05.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 21:05:33 -0700 (PDT)
Date:   Mon, 15 Apr 2013 21:05:31 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] tty: of_serial: allow rt288x-uart to load from OF
Message-ID: <20130416040531.GA4907@kroah.com>
References: <1365845618-16040-1-git-send-email-blogic@openwrt.org>
 <1365845618-16040-2-git-send-email-blogic@openwrt.org>
 <20130415181402.GA25194@kroah.com>
 <516CCBBA.8000103@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516CCBBA.8000103@openwrt.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnaaGMocutbTQDslVIM8N7UbccpGcupLf/h7iaPP1NVA4cg9NCaId4Tz3pvDQBBL87LjXd1
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Tue, Apr 16, 2013 at 05:55:38AM +0200, John Crispin wrote:
> On 15/04/13 20:14, Greg Kroah-Hartman wrote:
> >On Sat, Apr 13, 2013 at 11:33:36AM +0200, John Crispin wrote:
> >>In order to make serial_8250 loadable via OF on Ralink WiSoC we need to default
> >>the iotype to UPIO_RT.
> >>
> >>Signed-off-by: John Crispin<blogic@openwrt.org>
> >>---
> >>  drivers/tty/serial/of_serial.c |    5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
> >>index b025d54..42f8550 100644
> >>--- a/drivers/tty/serial/of_serial.c
> >>+++ b/drivers/tty/serial/of_serial.c
> >>@@ -98,7 +98,10 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
> >>  		port->regshift = prop;
> >>
> >>  	port->irq = irq_of_parse_and_map(np, 0);
> >>-	port->iotype = UPIO_MEM;
> >>+	if (of_device_is_compatible(np, "ralink,rt2880-uart"))
> >>+		port->iotype = UPIO_AU;
> >>+	else
> >>+		port->iotype = UPIO_MEM;
> >Why are you putting device-specific things into a generic driver?
> >Shouldn't this be able to be described in device tree without relying on
> >an vendor-specific test in this driver?
> >
> >greg k-h
> >
> >
> Hi Greg,
> 
> would 'reg-io-type = "au";' sound better to you ?

I don't know, run it by the device tree people, they know this stuff, I
don't :(

greg k-h
