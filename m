Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 19:00:07 +0100 (CET)
Received: from mail-lb0-f179.google.com ([209.85.217.179]:46698 "EHLO
        mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815749AbaAQSACGivvA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jan 2014 19:00:02 +0100
Received: by mail-lb0-f179.google.com with SMTP id l4so1633916lbv.10
        for <linux-mips@linux-mips.org>; Fri, 17 Jan 2014 09:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uotvxPrGyNJpOiNwv4Hchh79i1cDMVnSWefNFXlidlw=;
        b=VQhik8gbfybbAunJctQbV9vMxnuzxruEz6A506Qb+Y2yHZH4u/b8cW0759AHhe3RQl
         cidPSRUXjKfkNK0XR5xdDd1nPw5WDyXafCwBo1gtpsgVCWrOm3QcvkSJj2QG7E3M1Zje
         4Ge1Xm09HSlFyDvUxSMCuPsOut+eGTeYKV4COn5+zSgOX5B4dtRNo6s3UMu1Q+PbJOPH
         kH7UQ2nolrDSRPGW9ln0qmv5N59A29D2qQ4pEPx+DscqsQ3TudCa4+nKDoUvrUqr2Xnk
         yEJggzcLR45fyaaw5TNRCfu2NKNA9GkysWsX5QW2ZC+Xyfrm0Go6ui7P0xPZSf444PJy
         ijww==
X-Gm-Message-State: ALoCoQmwYj0ujOP/BfJl0sCMeFZ6NKwOfLilbpi2ox5DYtXfybDjNe+rdSkkSX/GUzI1Ve0e2Z5y
X-Received: by 10.152.19.65 with SMTP id c1mr1722430lae.49.1389981595707;
        Fri, 17 Jan 2014 09:59:55 -0800 (PST)
Received: from wasted.dev.rtsoft.ru (ppp91-76-88-249.pppoe.mtu-net.ru. [91.76.88.249])
        by mx.google.com with ESMTPSA id qx1sm7224041lbb.15.2014.01.17.09.59.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 09:59:55 -0800 (PST)
Message-ID: <52D97DB1.9080306@cogentembedded.com>
Date:   Fri, 17 Jan 2014 22:00:01 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org
CC:     blogic@openwrt.org
Subject: Re: [PATCH] MIPS: APRP: Fix breakage due to new wait_event interface.
References: <1389977227-16694-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1389977227-16694-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39028
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 01/17/2014 07:47 PM, Steven J. Hill wrote:

> From: "Steven J. Hill" <Steven.Hill@imgtec.com>

> Commit 35a2af94c7ce7130ca292c68b1d27fcfdb648f6b changed the
> __wait_event*() interfaces. Fix the RTLX open() function to
> use the new interface.

> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>

    Deng-Cheng Zhu from the same firm posted such patch already. You should 
coordinate better. :-)

WBR, Sergei
