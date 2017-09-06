Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 14:32:18 +0200 (CEST)
Received: from mail-wm0-x243.google.com ([IPv6:2a00:1450:400c:c09::243]:35209
        "EHLO mail-wm0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbdIFMcHhVi8U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 14:32:07 +0200
Received: by mail-wm0-x243.google.com with SMTP id e64so5229097wmi.2;
        Wed, 06 Sep 2017 05:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SCbEIGNPjwCOO2cePBRckcfpPZvWOaa408jgazv1hZM=;
        b=NlOdaCAmvWteIW93ZL742ykvwtThoIXKSlgAzUi3fUpc4MaEZe8mXjiefroNXYY+Ji
         Cmt3i4+lDpji1QY+5DiDrgzGgQaizOwjVPlQlXSurW/fYockTqLL0iS+WRP2GS8dMhvg
         325rWbMlHQoJK3HZICuUs/iW/h5bp38yWlV9R6LOTybeWqCZxKjaD8j0asssyBBIYZKp
         Te/iOv8TcSPdQjcaVy3+bM6CsQgAr6qkIKPh7OLH3da8qmvWnEVOo3eyiGfJ3Iaql0OG
         ZmSKWUt+Pem18gBLrfc0U7/QQUnoh5LrAebJVPdLf/gm9V/65iy1K9MlcGp6jjvlcetW
         VWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=SCbEIGNPjwCOO2cePBRckcfpPZvWOaa408jgazv1hZM=;
        b=ZCdkbs2dFFGDYv5vs6ph0iHBnRNK6T4Owy4RI2R+9texBlGCISV6i8wSkZJk4Q3hNG
         LQ/zndaDEThfyNEmzrsYo4FXPDvUQ8zgy8FBYRHNMTgdptSj2jO+ZVxsOn0GhHV6E9MB
         IXfcrEgARnuf/2Lv1TPn8HmCny5azdvtww22XhdHKF8CAy7u5vTV0apvlNqh0vEFXhA7
         pcZZhEufFYKU2RUs6sYm3QVwQ7IKGhFB5hNHQtWnOTgRIF6MHkS2NPix1TESuAxRg0ZD
         wv9bTNjquBvC+BCeggF0Vhk/oNIlyqDjPcSzwSTEhPFMCs3LeVY9c8Jlj/M76Ob1IiTx
         jr8A==
X-Gm-Message-State: AHPjjUgZq4yGUKg++EVSvFAajIc+bIkldt68PzVs3z7i098TBvCYnhTR
        4fYiZJw+0Lo6NA==
X-Google-Smtp-Source: ADKCNb4dUBEJ6nkttqGEn1Tytrt4Jq48GtBZTC1Sf3+4nbaeUItPMo3vzx67oMYdWwJ+xvlQ34Q8cQ==
X-Received: by 10.28.54.206 with SMTP id y75mr1460039wmh.53.1504701121958;
        Wed, 06 Sep 2017 05:32:01 -0700 (PDT)
Received: from localhost (net-188-152-76-252.cust.dsl.teletu.it. [188.152.76.252])
        by smtp.gmail.com with ESMTPSA id f19sm4267440wrf.85.2017.09.06.05.32.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Sep 2017 05:32:01 -0700 (PDT)
Date:   Wed, 6 Sep 2017 14:32:00 +0200
From:   Rocco Folino <rocco.folino@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     Ralf Baechle <ralf@linux-mips.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] MIPS: ath79: support devicetree selection
Message-ID: <20170906123200.GA21761@void>
Mail-Followup-To: Alban <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <john@phrozen.org>
References: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
 <20170906111435.GA1856@linux-mips.org>
 <20170906142005.67586253@avionic-0141>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906142005.67586253@avionic-0141>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <rocco.folino@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59948
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rocco.folino@gmail.com
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

On Wed, Sep 06, 2017 at 02:20:05PM +0200, Alban wrote:
> On Wed, 6 Sep 2017 13:14:35 +0200
> Ralf Baechle <ralf@linux-mips.org> wrote:
> 
> > On Fri, Aug 18, 2017 at 05:32:42PM +0200, Rocco Folino wrote:
> > 
> > > Allow to choose devicetrees from Kconfig.
> > > 
> > > Signed-off-by: Rocco Folino <rocco.folino@gmail.com>
> 
> I don't really see the point of this patch. Building the dtb doesn't
> take any significant time, so why add this extra complexity?

Because you need to select the SoC type in order to enable some drivers, for
example on the AR9331 to use the serial you need the CONFIG_SERIAL_AR933X
which depends on the CONFIG_SOC_AR933X.

Rocco
