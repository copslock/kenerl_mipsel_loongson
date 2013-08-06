Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Aug 2013 19:24:05 +0200 (CEST)
Received: from mail-oa0-f44.google.com ([209.85.219.44]:48829 "EHLO
        mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865173Ab3HFRX6kCZuY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Aug 2013 19:23:58 +0200
Received: by mail-oa0-f44.google.com with SMTP id l20so1344570oag.3
        for <multiple recipients>; Tue, 06 Aug 2013 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3LYkHB4OXTayhA/49R3gTrlCOAXSPJCe7pUJK7oY7YU=;
        b=04I/I8nlnwA/CnC7el1Q+ciIsdkca7VjI2vUzD/+HNG1bI41PKwNfLnSAcVeQoZydR
         oZLeml6yszt8gERWfaY867rEZNbHQ/40LkwsXXPpLhChbYziLpKG6B57ByXJ7EKdTYJs
         nOhJYRSYQDHgjKAu/yV1WzfVA9eRYnbQJlqz4T5YPX6e2ybdzDFqz2jT/loIdeVB5Cu9
         dAViz0fOpy7Esiwtu0wc0wbHd2Nj3RluTvFgxazEosjkEsefPjphFygyDEl5CN1E+crn
         Wedx0McNm3pbOvrF+TuaF92S9k+kIGK9WZ4pis7rrc2r/hriJnOxu+GGXa8CCjTEbyV6
         3UCg==
X-Received: by 10.42.83.84 with SMTP id g20mr130025icl.10.1375809831689;
        Tue, 06 Aug 2013 10:23:51 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id y2sm356592igl.10.2013.08.06.10.23.49
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 10:23:50 -0700 (PDT)
Message-ID: <52013124.3010701@gmail.com>
Date:   Tue, 06 Aug 2013 10:23:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 25/31] mips/kvm: Add some asm-offsets constants used by
 MIPSVZ.
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com> <1370646215-6543-26-git-send-email-ddaney.cavm@gmail.com> <20130616113102.GG20046@linux-mips.org>
In-Reply-To: <20130616113102.GG20046@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37440
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

On 06/16/2013 04:31 AM, Ralf Baechle wrote:
> Patch looks ok but why not combine this patch with the previous one?
>

Because even though they both touch asm-offsets.c, they are offsets for 
unrelated structures.  I could try distributing these changes across 
several other patches, but getting the patch dependencies/ordering 
correct can be tricky.

David Daney


>    Ralf
>
