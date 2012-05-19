Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 May 2012 08:08:40 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:46041 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901761Ab2ESGIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 May 2012 08:08:35 +0200
Received: by pbbrq13 with SMTP id rq13so5511054pbb.36
        for <linux-mips@linux-mips.org>; Fri, 18 May 2012 23:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=sender:from:subject:to:cc:in-reply-to:references:date:message-id
         :x-gm-message-state;
        bh=/z6dfECy8WPSTNrOWfn6gqjjWFEjDDGKBsNcGsBRZDw=;
        b=fMwdVYkgw3fj9YO8f5n+riuf9B/a66zIqzbFaZo1JQL9MjUo/eibWo/vjVkeA6kbZD
         qki2ZnC9RkQsRToHJ4TrQG8PJnRa+q4ZRAsZhkRy2h8g8ZT9Cpdtha7S3IgFJE00m8/V
         fiEsqgQwgqbZgPzjUUQxcthS7iyE33GA3Tbl2Mzjo+OqZNxgAgim9myYz0kvL3AozCBD
         vhVpk+BfojAbmqDMwvACW91O9QjMlF9Oj6Iim2MIvuCKGTHJUuF+DMx6lN8glZ+Rn4cM
         0S37dNTIQyCSGjStQWzQWYcYA8V2oLR8Xe0+oJX7QpDnc8V0K7UUw/N/cdUg/cn1Akjp
         BoZw==
Received: by 10.68.225.6 with SMTP id rg6mr8833164pbc.100.1337407709157;
        Fri, 18 May 2012 23:08:29 -0700 (PDT)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id ss8sm15266957pbc.43.2012.05.18.23.08.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 May 2012 23:08:27 -0700 (PDT)
Received: by localhost (Postfix, from userid 1000)
        id 0E8F53E046E; Sat, 19 May 2012 00:08:27 -0600 (MDT)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 5/5] MIPS: Octeon: Use device tree to register serial ports.
To:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
In-Reply-To: <1335489630-27017-6-git-send-email-ddaney.cavm@gmail.com>
References: <1335489630-27017-1-git-send-email-ddaney.cavm@gmail.com> <1335489630-27017-6-git-send-email-ddaney.cavm@gmail.com>
Date:   Sat, 19 May 2012 00:08:27 -0600
Message-Id: <20120519060827.0E8F53E046E@localhost>
X-Gm-Message-State: ALoCoQl1xqNDj1767qlNZCxEVPUm24TBCfRo9jPuVFsogRG4/oibU5/PjiTwFbQyWkZYiQTAqZmE
X-archive-position: 33374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, 26 Apr 2012 18:20:30 -0700, David Daney <ddaney.cavm@gmail.com> wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Switch to using the device tree to register serial ports.
> 
> Add all the ports with compatible = "cavium,octeon-3860-uart".  Octeon serial
> ports have their own device type, required port flags, and I/O
> functions, so using of_serial.c is not indicated.
> 
> We need to do this as late_initcall, as the 8250 driver must be
> initialized before we add any ports.  8250 initialization is done at
> device_initcall time.
> 
> The OCTEON_IRQ_UART{0,1,2} symbols are removed as they are now unused
> and interfere with irq_domain used by the device tree code.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>
