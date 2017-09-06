Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 16:00:21 +0200 (CEST)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:34778
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993156AbdIFOAHo66hw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 16:00:07 +0200
Received: by mail-wm0-x241.google.com with SMTP id l19so2402489wmi.1;
        Wed, 06 Sep 2017 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLElKXZXl+re/T/7dR+GMXVQCAzo+1WNeD0cA+GNZdI=;
        b=ROsCENKaZkiu9lJ0Kx86b8V5NZeHEyb0liDHf4H6rMvrkpI/gcaCtF093zK1UTJrrh
         qwu3AQHM7Oz9K/T4jauvpJU7xajIYyWG1HzG2STk4EBmLqAo5yVJM0+47nyFSu4IMKXZ
         dANVyxSvB+zvqXIuVm8Ul6EYYM9zKIP8IJQiMrlEfSuZhAXrUuNdKBt68+hUyv6uDbMN
         Xt7arPOH+qp75fI0Mqdw/EhVO3ZQ1g2lz7saWaOVMhqjE4SCloXVlATVfXDUgTwt7fVR
         OPH13wRQJGAgQDmZY2+EFCw9jMf84HLmdLRM7C3crLhnG5ombiLuOZKGw4Njmzw9nG/1
         aoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=MLElKXZXl+re/T/7dR+GMXVQCAzo+1WNeD0cA+GNZdI=;
        b=Mwkb2ZpY3eM6nShpxVbIxJ69Grxuz3s3z67Xxc1q1lYYRMd/TFbo+NhuWcU2nbc3hh
         AYneFMqmpnAPeoRgSsqemKC6MIzqIefPEr1aodldNLgB26Kakwo+uWiO+6AOOvrkD/Sz
         VkuM151Sp2pIsdQU+p1Yenb4lt0syfe6X63LPJbc4JEEXoeKuf7VtCZwYTCaYJA5c8FV
         bDIso0+sa5sQqtjfzDqwchAS+XgRjQ1rLqWaB5Rps7mMCyPPZxCn/Nts1aE47IkySOjk
         YZWTh+itnuOVC1dQEvdLcyTV7A/MSzjGekLXuhcofPdHmqXAyfxO83+S9uhxGqTBt/dq
         EGnQ==
X-Gm-Message-State: AHPjjUguFfGK5mjSExm0jc0npe1tCES1Z53+MYg4V5aLO7+8hMwbbyej
        Sb0m1b9fB7LMhQ==
X-Google-Smtp-Source: ADKCNb6SQvyxKPkV07QUucW/Z8Ka/Cntxr6yT9zpExR55YCSsIDpDnhOGTcMI/rEJtQ2YV9X0SugwQ==
X-Received: by 10.28.165.75 with SMTP id o72mr123721wme.12.1504706400861;
        Wed, 06 Sep 2017 07:00:00 -0700 (PDT)
Received: from localhost (net-188-152-76-252.cust.vodafonedsl.it. [188.152.76.252])
        by smtp.gmail.com with ESMTPSA id c78sm2543595wmd.7.2017.09.06.06.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Sep 2017 07:00:00 -0700 (PDT)
Date:   Wed, 6 Sep 2017 15:59:59 +0200
From:   Rocco Folino <rocco.folino@gmail.com>
To:     Alban <albeu@free.fr>
Cc:     Ralf Baechle <ralf@linux-mips.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH] MIPS: ath79: support devicetree selection
Message-ID: <20170906135959.GA25439@void>
Mail-Followup-To: Alban <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        John Crispin <john@phrozen.org>
References: <b78cb3ef8df8531efdb7b011743ad3f38978015d.1503070362.git.rocco.folino@gmail.com>
 <20170906111435.GA1856@linux-mips.org>
 <20170906142005.67586253@avionic-0141>
 <20170906123200.GA21761@void>
 <20170906153543.412774d5@avionic-0141>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906153543.412774d5@avionic-0141>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <rocco.folino@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59951
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

On Wed, Sep 06, 2017 at 03:35:43PM +0200, Alban wrote:
> On Wed, 6 Sep 2017 14:32:00 +0200
> Rocco Folino <rocco.folino@gmail.com> wrote:
> 
> > On Wed, Sep 06, 2017 at 02:20:05PM +0200, Alban wrote:
> > > On Wed, 6 Sep 2017 13:14:35 +0200
> > > Ralf Baechle <ralf@linux-mips.org> wrote:
> > >   
> > > > On Fri, Aug 18, 2017 at 05:32:42PM +0200, Rocco Folino wrote:
> > > >   
> > > > > Allow to choose devicetrees from Kconfig.
> > > > > 
> > > > > Signed-off-by: Rocco Folino <rocco.folino@gmail.com>  
> > > 
> > > I don't really see the point of this patch. Building the dtb doesn't
> > > take any significant time, so why add this extra complexity?  
> > 
> > Because you need to select the SoC type in order to enable some
> > drivers, for example on the AR9331 to use the serial you need the
> > CONFIG_SERIAL_AR933X which depends on the CONFIG_SOC_AR933X.
> 
> Seeing as this driver is the only one that make use of CONFIG_SOC_AR933X
> I would prefer removing this dependency. It would also open the way to have
> the driver built in COMPILE_TEST. A few more fixes might be needed but that
> would be better than such a workaround.

Yes, I agree!

Thanks,

Rocco
