Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Mar 2013 15:26:43 +0100 (CET)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:44265 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6819996Ab3CQO0lpxtff (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Mar 2013 15:26:41 +0100
Received: by mail-wg0-f49.google.com with SMTP id ds1so3246705wgb.4
        for <multiple recipients>; Sun, 17 Mar 2013 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:organization
         :user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type;
        bh=eg54avfjMIstxfojzY20iSyoWZtdQdLq1H5rHzdhz8w=;
        b=HTsfv0hi5uo+RIO52pbfWu6LFDZgWs6UWL73gfYeBvgVxu+AQYnQGUCwbbYcf+GDs4
         wbR47NDD9FNWn3aSErOljey0CnryCnpITLS5AS6EZ59qYMgJv7nnxITj0JxbFzHrw1No
         6LTqjdUewbB7je2G373XM2wfwFLUbpF+bexU1LVLBieob24RP7PCG+kfDsPZmYx0ECGJ
         JnS/ctGccEYZCwXMbIYFzOvIqAsT8gB+65cqnr9J4/nPMZ7ConZA/CFibLLcF7gMSNDK
         bKcyW6ql29M1UAeIoJOSiLtGl3g7HtclhoHdYTX8EVPsWoChK9knocli4bxjjg03fUyj
         OMSw==
X-Received: by 10.194.7.131 with SMTP id j3mr19764527wja.23.1363530396321;
        Sun, 17 Mar 2013 07:26:36 -0700 (PDT)
Received: from bender.localnet ([2a01:e35:2f70:4010:68f9:987c:e0ae:12df])
        by mx.google.com with ESMTPS id ex1sm9391050wib.7.2013.03.17.07.26.34
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 07:26:35 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: fix code generation for non-DSP capable CPUs
Date:   Sun, 17 Mar 2013 15:26:29 +0100
Message-ID: <4237452.TNx7F0KE0x@bender>
Organization: OpenWrt
User-Agent: KMail/4.9.5 (Linux/3.5.0-25-generic; KDE/4.9.5; x86_64; ; )
In-Reply-To: <0573B2AE5BBFFC408CC8740092293B5ACBB9B0@bamail02.ba.imgtec.org>
References: <1363267128-8918-1-git-send-email-florian@openwrt.org> <0573B2AE5BBFFC408CC8740092293B5ACBB9B0@bamail02.ba.imgtec.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-archive-position: 35904
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

On Saturday 16 March 2013 20:52:44 Steven J. Hill wrote:
> Florian,
> 
> I just tested this patch with our DSP testsuite and everything works. I also 
disassembled the vmlinux ELF binary to make sure the instructions were being 
generated correctly.
> 
> 
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

Great, thanks Steven!
-- 
Florian
