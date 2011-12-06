Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 13:02:59 +0100 (CET)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:44844 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab1LFMCv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 13:02:51 +0100
Received: by laah2 with SMTP id h2so507675laa.36
        for <multiple recipients>; Tue, 06 Dec 2011 04:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:date:in-reply-to:references
         :content-type:x-mailer:content-transfer-encoding:message-id
         :mime-version;
        bh=Nfp3KLGNYjOHzVKMuy3x7k2+jy1GcNZB8S1WdT5hDG8=;
        b=RHdyyL6LQ7OvfnJwvGstAeV36NkTMzWrM5ITaR3apHkrv4zSk1JQwiCKZV3DJQ9Li2
         SEWODygTwsLD2CRGcIGUxXoCuOCz/ILdNl8nAjTwEDlDX81v2fJ2TlBvcTq9PBuZkNyu
         zfKtw6+V/UIrhP6vw4jFBFjvXuEvdMVzxO9Ug=
Received: by 10.152.102.173 with SMTP id fp13mr8881702lab.24.1323172966088;
        Tue, 06 Dec 2011 04:02:46 -0800 (PST)
Received: from [192.168.255.2] (host-94-101-1-70.igua.fi. [94.101.1.70])
        by mx.google.com with ESMTPS id py2sm3653786lab.2.2011.12.06.04.02.44
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 04:02:45 -0800 (PST)
Subject: Re: [PATCH 0/7] MTD: MAPS: remove bcm963xx-flash
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Date:   Tue, 06 Dec 2011 14:02:44 +0200
In-Reply-To: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.0.3 (3.0.3-1.fc15) 
Content-Transfer-Encoding: 7bit
Message-ID: <1323172965.2163.5.camel@koala>
Mime-Version: 1.0
X-archive-position: 32043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4397

On Mon, 2011-12-05 at 16:08 +0100, Jonas Gorski wrote:
> While trying to improve the bcm963xx CFE partition parsing, I noticed
> that it could be completely replaced by the generic physmap flash
> driver using a custom parser.

Hi,

would you please send a version which applies cleanly to my
l2-mtd-2.6.git tree:

http://git.infradead.org/users/dedekind/l2-mtd-2.6.git

Artem.
