Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 02:35:04 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992618AbeC0Ae5V15Ka (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Mar 2018 02:34:57 +0200
Received: from mail-qk0-f177.google.com (mail-qk0-f177.google.com [209.85.220.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6287A2184A
        for <linux-mips@linux-mips.org>; Tue, 27 Mar 2018 00:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6287A2184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-qk0-f177.google.com with SMTP id o205so10546720qke.3
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2018 17:34:50 -0700 (PDT)
X-Gm-Message-State: AElRT7GAK8avvtWk3Sy10nPhXhAkViD1lRARPWjqxZhV7RqfYA4vjXMC
        p6RdP7BWnBoU5N0GYvUvhyK0r5XIDCxO7C4/kA==
X-Google-Smtp-Source: AIpwx482/+fpuCtrRD0mQPqU/EC2J1bFmUnGCPgid3vKAzZKZ0l2OaFtXohXnBEOSh/gORAfy3PicoGqjM0WtYrnXxY=
X-Received: by 10.55.121.1 with SMTP id u1mr9063517qkc.79.1522110889501; Mon,
 26 Mar 2018 17:34:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.213.166 with HTTP; Mon, 26 Mar 2018 17:34:29 -0700 (PDT)
In-Reply-To: <20180326225020.GF5862@lunn.ch>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com> <a5db6109-c5d9-f573-893c-f7d66c3168c2@gmail.com>
 <20180326222514.4eciw66aihhcjgtw@rob-hp-laptop> <20180326225020.GF5862@lunn.ch>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Mar 2018 19:34:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+T+TpoLixbi+jrrtUSp_wRSwrrP2Oe2igbapoFonx1FA@mail.gmail.com>
Message-ID: <CAL_Jsq+T+TpoLixbi+jrrtUSp_wRSwrrP2Oe2igbapoFonx1FA@mail.gmail.com>
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, Po Liu <po.liu@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63240
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

On Mon, Mar 26, 2018 at 5:50 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> ports and port collide with the OF graph binding. It would be good if
>> this moved to ethernet-port(s) or similar.
>
> Hi Rob
>
> Well, we have been using port in DSA since March 2013. ports is a bit
> newer, June 2016.

Yes, understood.

>
> Changing DSA is not going to happen. But new switch bindings could use
> ethernet-port(s). It just makes them inconsistent with existing switch
> drivers.

I'm not saying to change existing bindings, but evolve to something
that doesn't collide on new bindings if you don't have dependencies on
what the node names are. It's mainly so we can have something to key
off of to validate bindings better.

Rob
