Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 02:14:30 +0100 (CET)
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39014 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990504AbdLABOWrEDrM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 02:14:22 +0100
Received: by mail-ot0-f196.google.com with SMTP id v21so7821384oth.6;
        Thu, 30 Nov 2017 17:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ugb0b/o+HwJGrB9hAsQxaGhvqhh/zxu/rCkQMThO0a0=;
        b=g9cUpQuXxEjAdgmoi3N2svWsn8wb4BajZW9hPYNKe33l0aDDnszbe8JOt1PLs94tHv
         a+yupKTe9kgU91GtytvfVGHbn9VKNDQZ4tMjuvSfHk2SE7TDIcZrVPgubgrjuPNzBTb1
         sHm/up5G4mw6OZoAgtFT5510NvndtKyJBNIWvdC7+mmtSCoXTS1nPlI7tnYdBahvUHxC
         6UmAPUFmTY8tLlDsyh5sMzSfthm9EORBt6S/9PGW+8GUnAhCPu1DiM5sYdXcCrOTPmbn
         Um1h1/AU8sYZG0jtECzHz81079qlbHoy4Yeqqh6oGaEXSZJpbNj6ZNupqMnEZtniIFtd
         THMg==
X-Gm-Message-State: AJaThX4Muc2xVpl04oLh2Pnb0p9r1xRI+hLuayQWS/Y9IwBzqjM2ezXc
        /3IQmv16gGMmlpwbRv1OhA==
X-Google-Smtp-Source: AGs4zMbhVeqn4nDCSBOL3zzbqAZDS3qYzcS8afbCMJ+9XzKKtkPFhPvKbxcnASL+BpLBlKLL398Jng==
X-Received: by 10.157.47.137 with SMTP id r9mr6619900otb.108.1512090856582;
        Thu, 30 Nov 2017 17:14:16 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id p25sm2428967ote.7.2017.11.30.17.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 17:14:15 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:14:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     James Hogan <james.hogan@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/13] dt-bindings: Add vendor prefix for Microsemi
 Corporation
Message-ID: <20171201011415.2y5qabgofwc5eecd@rob-hp-laptop>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-2-alexandre.belloni@free-electrons.com>
 <20171128161014.GG27409@jhogan-linux.mipstec.com>
 <20171128162245.GH21126@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128162245.GH21126@piout.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61253
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

On Tue, Nov 28, 2017 at 05:22:45PM +0100, Alexandre Belloni wrote:
> On 28/11/2017 at 16:10:14 +0000, James Hogan wrote:
> > On Tue, Nov 28, 2017 at 04:26:31PM +0100, Alexandre Belloni wrote:
> > > Microsemi Corporation provides semiconductor and system solutions for
> > > aerospace & defense, communications, data center and industrial markets.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > > ---
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: devicetree@vger.kernel.org
> > 
> > Nit: Usually the Cc list goes before the --- line so that it is included
> > in the git history (i.e. these people had the opportunity to comment).
> > 
> 
> Ok, it depends on the maintainer, some people prefer leaving that out of commit log.
> I'm fine with adding those back in.

Really? First, I've heard that.

In any case,

Acked-by: Rob Herring <robh@kernel.org>
