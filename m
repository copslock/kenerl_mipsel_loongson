Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 11:33:28 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:48684 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817054Ab2JDJdVad5p5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 11:33:21 +0200
Received: by mail-ee0-f49.google.com with SMTP id c1so217070eek.36
        for <multiple recipients>; Thu, 04 Oct 2012 02:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=YFSHaT4f5qjOgM7z8NugUyswadzYjmmi9yttmnlsM+8=;
        b=famSCjGlfK6/GE/LBX5V1xNoDVyxHYaDd/T3NjqrVhG5SDEZAH7JIULSK4VDHx0MXK
         GRzUsECei08DYBMHpU27I1A/MpidAkvdj6bHqB3aRm+rVvTIml7Xjh488AeIKgs86u78
         oJIRRnJA12UvaACHCHuEA5BQS3tSEap802C8/SJogZ8cQcVn6XEE/XqdNSwPL9gogY8+
         8Ovx69c+Ci82EeDdYF45ZW/Wa5XCN1aROG59jZfPh9GAnVuvEFzLii4jV7CkbY6sl2+3
         Cn3xhX94tj6uWWqVVIUCcr3+Px191dc1irTa24rEaZiu5VjY4TIPrPZorq0z5hxE1RfU
         /EZA==
Received: by 10.14.223.4 with SMTP id u4mr3219801eep.19.1349277925765;
        Wed, 03 Oct 2012 08:25:25 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id t1sm10326393eeo.3.2012.10.03.08.25.24
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 08:25:24 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>,
        Thomas Meyer <thomas@m3y3r.de>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/25] MIPS: Alchemy: use the OHCI platform driver
Date:   Wed, 03 Oct 2012 17:24:25 +0200
Message-ID: <2608261.j829MQZAuC@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.5 (Linux/3.2.0-24-generic; KDE/4.8.5; x86_64; ; )
In-Reply-To: <CAOLZvyHyQGZ=Rs1=k07Saq16aZcntUe8N0Fc5iMoeOTeMpjcSw@mail.gmail.com>
References: <1349276601-8371-1-git-send-email-florian@openwrt.org> <1349276601-8371-26-git-send-email-florian@openwrt.org> <CAOLZvyHyQGZ=Rs1=k07Saq16aZcntUe8N0Fc5iMoeOTeMpjcSw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 34567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wednesday 03 October 2012 17:21:37 Manuel Lauss wrote:
> On Wed, Oct 3, 2012 at 5:03 PM, Florian Fainelli <florian@openwrt.org> wrote:
> > This also greatly simplifies the power_{on,off} callbacks and make them
> > work on platform device id instead of checking the OHCI controller base
> > address like what was done in ohci-au1xxx.c.
> 
> That was by design -- the base address is far more reliable in identifying 
the
> correct controller instance than the platform device id.   There are systems
> in the field which don't use the alchemy/common/platform.c file at all.

Fair enough, but the way it was done previously was very error-prone if the 
base address changed for any reason in the platform code, and you did not 
notice it had to be changed in the OHCI driver too, then it simply did not 
work. By systems in the field you mean out of tree users? If so, I'd say that 
it's up to you to get them maintained or merged.
--
Florian
