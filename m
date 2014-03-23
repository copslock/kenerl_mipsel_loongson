Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 23 Mar 2014 20:01:51 +0100 (CET)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:44303 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816671AbaCWTBpvdkEI convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 23 Mar 2014 20:01:45 +0100
Received: by mail-ob0-f172.google.com with SMTP id wm4so4838804obc.31
        for <multiple recipients>; Sun, 23 Mar 2014 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=YKjid3vwGHe43DCyLMVemGlfFKge0G7TyOP3veIeV1A=;
        b=KcwR2wRte7znj4BpjAhFErDkVUk7Kml37jQXaArMWeBYxYuu8nDAiTncInWi0HdoPd
         zw5xn+C5aJ+WbyrNnqqVm/K3nSg2cgLlLg8DS5T0w4VZRYRoz5si9IkIZTCJGVS/npr7
         pTyAmdd91fP/hPfxaE3/iOyygqY2p71rf4fA24wBqxlXO0nkLYviGHpIf5oOltPessrD
         nJf9L0kDWkHB/3kcNbexNkRuSQUgZXvxYdJKBvGIAJw22SQzBEwMS+FoAzMltjy7HkFd
         rb4vcKDlGloziH0kIT3IyDR1eUT3RZYZZ3cMs/mwwh3j+HLOjO/vAcKfSeYNr91E+1iB
         AsrQ==
X-Received: by 10.182.233.45 with SMTP id tt13mr23341286obc.9.1395601295655;
        Sun, 23 Mar 2014 12:01:35 -0700 (PDT)
Received: from lenovo.localnet (ip68-5-18-231.oc.oc.cox.net. [68.5.18.231])
        by mx.google.com with ESMTPSA id yu5sm49955562oeb.11.2014.03.23.12.01.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 23 Mar 2014 12:01:34 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        blogic@openwrt.org
Subject: Re: [PATCH 2/2] MIPS: fix DECStation build for L1_CACHE_SHIFT value
Date:   Sun, 23 Mar 2014 12:01:31 -0700
Message-ID: <4353562.NNfMoORRNC@lenovo>
Organization: OpenWrt
User-Agent: KMail/4.11.5 (Linux/3.11.0-18-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <alpine.LFD.2.10.1403230203410.21669@eddie.linux-mips.org>
References: <1390327294-2618-1-git-send-email-florian@openwrt.org> <1390327294-2618-2-git-send-email-florian@openwrt.org> <alpine.LFD.2.10.1403230203410.21669@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39558
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

Le dimanche 23 mars 2014, 02:16:27 Maciej W. Rozycki a écrit :
> On Tue, 21 Jan 2014, Florian Fainelli wrote:
> > When support for the DECStation is enabled, it will default to use a
> > MIPS R3000 class processor. This will cause an intentional build failure
> > to popup because MIPS_L1_CACHE_SHIFT and cpu_dcache_line_size()
> > disagree. Fix this by selecting MIPS_L1_CACHE_SHIFT_2 when we build
> > targetting a MIPS R3000 CPU to fix that build failure and satisfy all
> > requirements.
> 
>  Thanks for your contribution.  However I just built a pristine ToT LMO
> kernel for an R3000 DECstation and that went fine, I got no error.  Can
> you provide me with a way to reproduce the problem?

The build failure was only transient, in conjunction wit this patch applied:

http://www.linux-mips.org/archives/linux-mips/2014-01/msg00183.html

which was then reverted.

> 
>  I am not opposed to your change per se, it may make sense regardless.
> However using a value of MIPS_L1_CACHE_SHIFT that is too high results in
> wasting some memory, but should otherwise be safe I believe, so I'm not
> really convinced adding this config infrastructure is going to pay off.

Not quite sure what "infrastructure" you are referring to here.

MIPS_L1_CACHE_SHIFT_<N> is just a bunch of Kconfig symbols that platform can 
select, to avoid an ever-growing list of:

default 5 if MIPS_FOO && MIPS_BAR && MIPS_BAZ

I think that this patch is still applicable as it makes it more accurate which 
L1_CACHE_SHIFT_SIZE is really required for a given CPU configuration 
DECSstation, and will avoid overbooking that value when R3000 CPUs are 
configured/used specifically here.
-- 
Florian
