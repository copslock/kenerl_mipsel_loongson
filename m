Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 13:28:36 +0200 (CEST)
Received: from mail-la0-f45.google.com ([209.85.215.45]:36496 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014850AbbDAL2e6FqKB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 1 Apr 2015 13:28:34 +0200
Received: by labe2 with SMTP id e2so34114642lab.3;
        Wed, 01 Apr 2015 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Uxca8HmolZqLnIzKTeB2Sg0L9zTPU4yCYZGPYEhuCUo=;
        b=cX4kIBXnKlJeIe8cKOxQDmlwzTW5q9AoPyhz22vWLU5cjRUQAo3aJqzLbyYJG+yU86
         Do85/L1WYPVrs+BZsfDep6LxW1PVUWxlB6BJsRQ4sCqsOxcLEQhEDeLuDc4+pRNHld7g
         8AoktNhq+XNVz+jjmr5HWLKqulGbxcon7ufOlnyZUbJdgmvCrrC27BpjeWEDs2c4n/aF
         P6PNvsAbGBT3eZ6FzwGHdFF4XnMY7BbwHAQLT+mvV2PBIpbz9KmOBG1eqWu+oBeKkh8h
         IkjD//0fVNY5JwTxg5tKAYvybZCZUSD6x+a4+LSJnqcvF6KKG0mxWO4a1x586UN18+0J
         woBg==
MIME-Version: 1.0
X-Received: by 10.112.140.38 with SMTP id rd6mr34970689lbb.116.1427887710782;
 Wed, 01 Apr 2015 04:28:30 -0700 (PDT)
Received: by 10.112.11.229 with HTTP; Wed, 1 Apr 2015 04:28:30 -0700 (PDT)
In-Reply-To: <551BD541.7080707@cogentembedded.com>
References: <1427869385-23333-1-git-send-email-zajec5@gmail.com>
        <551BD33B.5030707@cogentembedded.com>
        <CACna6ry-vFUPuwp1GLv9PbE219zug7n9S=Xr=1mrdTx=JStnvQ@mail.gmail.com>
        <551BD541.7080707@cogentembedded.com>
Date:   Wed, 1 Apr 2015 13:28:30 +0200
Message-ID: <CACna6rxoFe3BH9nmd2qEeRw05ndN5U09-JHKRY6DvRGBPNU4ZA@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: BCM47XX: Include io.h directly and fix brace indent
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 1 April 2015 at 13:23, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 4/1/2015 2:20 PM, Rafał Miłecki wrote:
>> I was feeling a bit unsure about sending two so trivial patches: one
>
>> for single-line include, second for single-line indent. So I merged
>> them.
>
>    No need to be unsure about this. Doing one thing per patch is perfectly
> legal and certainly better than doing 2 unrelated things. :-)

OK, I promise to note that for the future, thanks!

-- 
Rafał
