Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2017 16:53:17 +0100 (CET)
Received: from mail-lf0-x236.google.com ([IPv6:2a00:1450:4010:c07::236]:33980
        "EHLO mail-lf0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993919AbdALPxJg0Hl6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2017 16:53:09 +0100
Received: by mail-lf0-x236.google.com with SMTP id v186so15933393lfa.1
        for <linux-mips@linux-mips.org>; Thu, 12 Jan 2017 07:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:references:to:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1XRdB6+woEoPIFIzdROV46XkV3VusOtCKknGiL09tVE=;
        b=qQiG+T9eXnUKXgRcmv1xurbYPI5bckmjW/HQqjnLycnlFZtWomM8iZPeOtq7glWUuY
         h4RhWcyldnUhY6m//U48ndkzAqlu77EbdnZPKcgi80TWKSEx1CuKb4SsOLMm5T6/KxAr
         4YdD/zWuleyPSLxbPjCPoodLJid/ZPgKsH2G1XyIzG5dWt6Gebuv8pX8KzdrPOsM2t4e
         a8kJAtxWBYyCmZPYBeisRkxSpCREDxSgvH+F8YYjh33QnnavdU4szKtvpecOoXqV9GKE
         GOTQgiCPJLHuSatc4XoPd3bqP9SrZzpgiCxkMR579Evj2EXQOqJ70tlHnx1Ih7EwuB3M
         QpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:references:to:cc:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=1XRdB6+woEoPIFIzdROV46XkV3VusOtCKknGiL09tVE=;
        b=nGwfNQ3PvqkjCLHlWpKRy1+jdKHZf51+WrB+IM3qCovlUyJSplbAXLS93VqnKbLy8K
         s8yM8OXuRqnd2PDrwSKyEv547kJDGpRpwU0QGFnoU6OivU5Jb7BeNW0gF/uED67Pq0JB
         sHpCAgAjHtxcSaQTvDIfoIhQ6QNxE0iY55hGJq3J0YkihB/8VZbXHkXWs8WuG++3Qs6B
         Iy5XrgXHqOUbcHYWyvSOirz4ZLds08rCc3SAGlu+VLUQ23AIO/fkQCSgbEOpw5aM2xkr
         ykKRwtWbLSmGnxeoYNLR0LId2DC/nzr5zSHb4Xa53fieplPsWJG5QQPYYeQck7XBCwMi
         njbQ==
X-Gm-Message-State: AIkVDXL3Yq6E3S4ddYRnR6aog40Ao7V06f0+WxMEaqXNc/BVsbf0TK192w+K0+4sqjMIRXe+
X-Received: by 10.25.21.142 with SMTP id 14mr1528399lfv.138.1484236384124;
        Thu, 12 Jan 2017 07:53:04 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:ec62:e68a:f008:ebc2? ([2a01:e35:8b63:dc30:ec62:e68a:f008:ebc2])
        by smtp.gmail.com with ESMTPSA id j11sm2021068lfd.23.2017.01.12.07.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2017 07:53:03 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2 7/7] uapi: export all headers under uapi directories
References: <bf83da6b-01ef-bf44-b3e1-ca6fc5636818@6wind.com>
 <1483695839-18660-1-git-send-email-nicolas.dichtel@6wind.com>
 <1483695839-18660-8-git-send-email-nicolas.dichtel@6wind.com>
 <20170109125638.GA15506@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-nfs@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-rdma@vger.kernel.org,
        fcoe-devel@open-fcoe.org, alsa-devel@alsa-project.org,
        linux-fbdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        airlied@linux.ie, davem@davemloft.net
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <464a1323-4450-e563-ff59-9e6d57b75959@6wind.com>
Date:   Thu, 12 Jan 2017 16:52:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170109125638.GA15506@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <nicolas.dichtel@6wind.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.dichtel@6wind.com
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

Le 09/01/2017 à 13:56, Christoph Hellwig a écrit :
> On Fri, Jan 06, 2017 at 10:43:59AM +0100, Nicolas Dichtel wrote:
>> Regularly, when a new header is created in include/uapi/, the developer
>> forgets to add it in the corresponding Kbuild file. This error is usually
>> detected after the release is out.
>>
>> In fact, all headers under uapi directories should be exported, thus it's
>> useless to have an exhaustive list.
>>
>> After this patch, the following files, which were not exported, are now
>> exported (with make headers_install_all):
> 
> ... snip ...
> 
>> linux/genwqe/.install
>> linux/genwqe/..install.cmd
>> linux/cifs/.install
>> linux/cifs/..install.cmd
> 
> I'm pretty sure these should not be exported!
> 
Those files are created in every directory:
$ find usr/include/ -name '\.\.install.cmd' | wc -l
71
$ find usr/include/ -name '\.install' | wc -l
71

See also
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.headersinst#n32


Thank you,
Nicolas
