Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 02:31:43 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35176 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822097AbaDVAbknxgb0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 02:31:40 +0200
Received: by mail-ig0-f173.google.com with SMTP id hl10so2383052igb.12
        for <linux-mips@linux-mips.org>; Mon, 21 Apr 2014 17:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OzNyxZq7OG25tF7rkowfKcUOohXfIAxmaksVBDRuazc=;
        b=yq1IZJHYKTM+trbNOWLuFysnMssrQKGaD76odBMe+QR0Kj1+MtbeBTA+T0ltpDbAbO
         NVPW4f374jtEW+xJ5b5qFa8qMhYvcTUX9hZBY3v5P3D2ws+2fBsLWHtM5WtPirZe/4tR
         JMhUs5pwcfdijnZ0HFvtIZBuS4o0PDLgDwRvN6Fo+GTxAcQ3TyrZ/qSpwlTGrhbEuLGm
         X2E3T8LhOS10dnkLF+wzQQYUsiFU2mXXaz910fQsNqHGH09Y5fDzcaOzT8MtDPoFNmDs
         IB38vqlDndNBmzAqpz2/+9KufFsFhkkm7tDIJZ92d9HDIh51fKs0kxlA61ErqAwklejV
         b3Zg==
X-Received: by 10.50.36.66 with SMTP id o2mr25547356igj.24.1398126694099;
        Mon, 21 Apr 2014 17:31:34 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id ng8sm23898981igb.6.2014.04.21.17.31.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 17:31:33 -0700 (PDT)
Message-ID: <5355B864.7090209@gmail.com>
Date:   Mon, 21 Apr 2014 17:31:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Holger Freyther <holger@freyther.de>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 0/2] Implement perf_callchain_user
References: <1313022966-28152-1-git-send-email-zecke@selfish.org> <loom.20110822T193146-370@post.gmane.org> <loom.20140421T105026-95@post.gmane.org>
In-Reply-To: <loom.20140421T105026-95@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 04/21/2014 01:51 AM, Holger Freyther wrote:
> Holger Freyther <zecke <at> selfish.org> writes:
>
>
>>
>> Comments? Should this go somewhere else?
>
> looking at the latest kernel userspace backtrace support does
> not appear to be implemented for perf? Do you intend to support
> it anytime soon?
>

I implemented it for MIPS, the patches are on the relevant mailing 
lists.  Perhaps some day they will get merged.

David Daney
