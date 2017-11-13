Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 13:42:50 +0100 (CET)
Received: from mail-pf0-x232.google.com ([IPv6:2607:f8b0:400e:c00::232]:54138
        "EHLO mail-pf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdKMMmo0tBQS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 13:42:44 +0100
Received: by mail-pf0-x232.google.com with SMTP id b6so11493600pff.10
        for <linux-mips@linux-mips.org>; Mon, 13 Nov 2017 04:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gimpelevich-san-francisco-ca-us.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dr8qqIOPHfmd5wfIKZPfb/HC8aWMB/02PW8XS0a69m8=;
        b=P+Yy9XGP0qHFkeACMdACiI8nKt+ZWBM6rfCKl5s4hzSHPo/IZGzZRZEmc8JDR5jIsZ
         0snza7YKQe0xmzzMKJcxAJpeoyXVXjtB1XbJZhfWAA67Mv8GSmmBDzAKED3MoYl8MZZ9
         EmUlBF+hdYj32R2GdiP06UzMl2GV3Y0xeciKTirg9ASVSViwHznnQj9s1+EAqJJbzrnW
         fEaFkCmUhUnu/KiUpHXgzlPPHqaagH2N9niaS7WPFn+RMTzzuFn1ShN6lErEe/Us1N4F
         VBVbNoL9GqGGKL2/d4B8t2W2XeOxHlwsXkQ7FZ8C/WycCiFyHl7yzQxdCMjW/AcoeVdv
         zbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dr8qqIOPHfmd5wfIKZPfb/HC8aWMB/02PW8XS0a69m8=;
        b=YBsTMG+ofV/bocVLm2Nq57uNkpIZNVAq0sqlN8LXIqeHsPc3ijQ828hQTxt4P3KSwj
         MqY0U0KiyIIGodbFcEYyY2DHIO6Jv3JMnMnHOdvptbIUZK4qC4+V2Q5zh8+urJCTGRiN
         9Sdkh2LqTpaygFqdzIJ3fr8f1shqMSbUbhQOkNlbsWFNfURaQ0UZ6ZmE6cBebqKBW647
         nifqiAvJ7u2upTW8x0iptDm9ah2L6yk0B9KV1KVCRreaBtj0PpvUBKOnP3JOojRyA+CB
         kqOG4iDl7x82ecyd2cUky5YZ0tABCPVu5DNs4BvZDaXOfzmTy5BVqYHYWPpZsyQ0Pu8p
         MIIQ==
X-Gm-Message-State: AJaThX58YsGXT2kK04vxH2lk0KDJevdbMvwiOnWLHzyUkmA9znf5yWDq
        wERYl10lS6KwmA4L2RdF8WTrdg==
X-Google-Smtp-Source: AGs4zMbMKL349eCSlQ+V47IvEUF2PiQUWRqFQymg0nDTbkrhUlbRrDVrmawvuU/zmAqoItZHDZMUXA==
X-Received: by 10.159.204.146 with SMTP id t18mr8629633plo.83.1510576957737;
        Mon, 13 Nov 2017 04:42:37 -0800 (PST)
Received: from [75.208.18.0] (0.sub-75-208-18.myvzw.com. [75.208.18.0])
        by smtp.gmail.com with ESMTPSA id b9sm26274115pgu.20.2017.11.13.04.42.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2017 04:42:37 -0800 (PST)
Message-ID: <1510576953.9806.1.camel@chimera>
Subject: Re: [PATCH] MIPS: implement a "bootargs-append" DT property
From:   Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Date:   Mon, 13 Nov 2017 04:42:33 -0800
In-Reply-To: <CAMuHMdUtHhSLbrgmOW7gkEUg8pif+Ddc-zZgWzCZ4WL3JTeOKg@mail.gmail.com>
References: <1510420788-25184-1-git-send-email-daniel@gimpelevich.san-francisco.ca.us>
         <20171113112312.GZ15260@jhogan-linux>
         <CAMuHMdUtHhSLbrgmOW7gkEUg8pif+Ddc-zZgWzCZ4WL3JTeOKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <daniel@gimpelevich.san-francisco.ca.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel@gimpelevich.san-francisco.ca.us
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

On Mon, 2017-11-13 at 13:31 +0100, Geert Uytterhoeven wrote:
> I've seen other use cases, e.g. the extension of the du node's
> "clocks" and
> "clock-names" properties from arch/arm64/boot/dts/renesas/r8a7795.dtsi
> to
> arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts.
> 
> To avoid the proliferation of "-append" versions of existing
> properties, what
> about handling this in dtc, by adding support for an
> "/append-property/"
> keyword?

That would not address use case #2 that I mentioned, where the dtb would
have a "bootargs-append" property but no "bootargs" property.
