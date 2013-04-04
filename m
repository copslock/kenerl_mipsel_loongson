Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Apr 2013 13:54:32 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:52090 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6832029Ab3DDLybI47l9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Apr 2013 13:54:31 +0200
Received: by mail-la0-f42.google.com with SMTP id fe20so2407516lab.29
        for <linux-mips@linux-mips.org>; Thu, 04 Apr 2013 04:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=vS9RdLlST1iRIcT9qkC+E34pLQgYc4w9WlNbpSYFfHc=;
        b=EFAUB7fi74csk+TSivlZY0v0hoAOHfpBwsaTvTVpykoFh4zUUrkKP2oJUzFpao1QV/
         XfwC2FgnneCR+iwf/F5c4Bcmq8KvRFKKmCqKnTEDK0C5pdwPDDJw9z/2/whkj13v6R65
         +pYc8lD7TwcvlRQh1o9fUJTPekI81t8U8QIS/3+0Zp019t2nRhtvSVtMReKzbFq1sUxQ
         JqNs5KukObjwPT2oi3CsUCs64KvOpK8y6086Z+KRQUI652eAl6ryk1tOkrHyoDvW2qB6
         NRkwhU6qGJvKunSVe86fE1OvWN5fJspc7gQAVXdB2hu/nOzS/X64x6tw1Dg04rhW2+of
         oFSw==
X-Received: by 10.152.29.232 with SMTP id n8mr3131358lah.55.1365076465289;
        Thu, 04 Apr 2013 04:54:25 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-82-171.pppoe.mtu-net.ru. [91.79.82.171])
        by mx.google.com with ESMTPS id m9sm2314366lbm.3.2013.04.04.04.54.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 04:54:24 -0700 (PDT)
Message-ID: <515D69B6.6040302@cogentembedded.com>
Date:   Thu, 04 Apr 2013 15:53:26 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Paul Bolle <pebolle@tiscali.nl>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Alchemy: Fix typo "CONFIG_DEBUG_PCI"
References: <1365074738.1830.38.camel@x61.thuisdomein>
In-Reply-To: <1365074738.1830.38.camel@x61.thuisdomein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkIE7leqZdF28gf2IXyIUBwBdLolcCKXKsNvCZ6gjxlXPCQgjFoG+SUb5l0BCtE9KJXHwZs
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36014
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

On 04-04-2013 15:25, Paul Bolle wrote:

> Also add a newline to a debugging printk that this fix enables.

> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> 0) Entirely untested. Adding the newline adds a checkpatch warning for
> over 80 characters lines.

> 1) Typo was added in v3.2, through commit
> 7517de348663b08a808aff44b5300e817157a568 ("MIPS: Alchemy: Redo PCI as
> platform driver").

     This is the information for the changelog.

WBR, Sergei
