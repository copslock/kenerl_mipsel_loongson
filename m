Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Mar 2013 18:45:00 +0100 (CET)
Received: from mail-wg0-f41.google.com ([74.125.82.41]:64592 "EHLO
        mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816859Ab3CPOGYiW8hx convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Mar 2013 15:06:24 +0100
Received: by mail-wg0-f41.google.com with SMTP id ds1so1348653wgb.4
        for <multiple recipients>; Sat, 16 Mar 2013 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=LCJJJxILpnubTQy/uD6B39xlS20WPtkr89WBF6fyWlw=;
        b=XXFazFpkwI7gZFH1O88zmC8pblsI1JCX3J4GWcN9To0cJXghvZtqS/dvDF+tcCJha5
         GWpO7yJ5Ma3uCM6ClMFTl15nB8uRaWO/mKhat04nUg8lzdCV6q7Wa8msB8Dg9pDKEg5N
         wbYF16toaklAT5luVxjPWX7EavzO7qzqPVqXNPDE6dqY2IR55ofcZ+FIW+jrm0CUYq1R
         CE4vdBUSFcXDIZjNrXtTpS4fHefMMqb1q5MeC43vlLUmM2X3l6rBCy2v+bhofzO10qvH
         X1N6pyypAFxSf9niw7EyXYAuVae7T+hFjTuQSlQER+1LFYMsiMgpcBoGsAFEnVSaxPCS
         +WPA==
X-Received: by 10.194.10.202 with SMTP id k10mr16282580wjb.53.1363442779257;
        Sat, 16 Mar 2013 07:06:19 -0700 (PDT)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id h10sm3921165wic.8.2013.03.16.07.06.16
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 07:06:17 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: fix code generation for non-DSP capable CPUs
Date:   Sat, 16 Mar 2013 15:06:14 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "blogic@openwrt.org" <blogic@openwrt.org>
References: <1363267128-8918-1-git-send-email-florian@openwrt.org> <0573B2AE5BBFFC408CC8740092293B5ACBA1F3@bamail02.ba.imgtec.org>
In-Reply-To: <0573B2AE5BBFFC408CC8740092293B5ACBA1F3@bamail02.ba.imgtec.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <201303161506.14881.florian@openwrt.org>
X-archive-position: 35909
X-Approved-By: ralf@linux-mips.org
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

Hey Steven,

Le jeudi 14 mars 2013 15:22:28, Steven J. Hill a écrit :
> Florian,
> 
> Let me test this patch out with our DSP testsuite and then I can give you
> an ACK or NACK. Thanks!

Have you been able to give this a try?
-- 
Florian
