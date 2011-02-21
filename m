Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Feb 2011 20:45:56 +0100 (CET)
Received: from mail-ew0-f53.google.com ([209.85.215.53]:54967 "EHLO
        mail-ew0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491079Ab1BUTpx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Feb 2011 20:45:53 +0100
Received: by ewy7 with SMTP id 7so704896ewy.26
        for <linux-mips@linux-mips.org>; Mon, 21 Feb 2011 11:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:mail-followup-to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=wylP01Qfd/4b9W2GtKTd3CXo6gPJ/zAGdUD3QXzwDOs=;
        b=tr1Meluh5YuwqpADNef6gCcS6HXUZlNqGXc+zENx/I0QBOOgA9DgAO4dEVgTe/wnd6
         0wCJzRemQ8GhrgKYfwo1zPeznw38sgL8JYz1O9d1lUtOE+k6KYC4Gj1YfkpjfByorq19
         1pIcHVAQnmcY9epAfPmKcZfSbf9U1eGD2MWvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:mail-followup-to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type;
        b=rgve48zksyopJdQDGYjlXdeGEd2NNoY9kaDPdWwjPCdhkSfB15laRLIeKDcxAg/VWy
         jBw3/dTBojwWb6grpcSfZfTyXpCQ8biu1wjWn03sP3ajyFyb/MzERNNxYHgYZLKPZIep
         5idEPEHdcFULyANVH9NbBJB2hzktLxgn8/TQw=
Received: by 10.213.17.133 with SMTP id s5mr315888eba.76.1298317547858;
        Mon, 21 Feb 2011 11:45:47 -0800 (PST)
Received: from localhost (rsandifo.gotadsl.co.uk [82.133.89.107])
        by mx.google.com with ESMTPS id t5sm5209579eeh.2.2011.02.21.11.45.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 11:45:46 -0800 (PST)
From:   Richard Sandiford <rdsandiford@googlemail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Mail-Followup-To: David Daney <ddaney@caviumnetworks.com>,linux-mips <linux-mips@linux-mips.org>,  GCC <gcc@gcc.gnu.org>,  binutils <binutils@sourceware.org>,  Prasun Kapoor <prasun.kapoor@caviumnetworks.com>, rdsandiford@googlemail.com
Cc:     linux-mips <linux-mips@linux-mips.org>, GCC <gcc@gcc.gnu.org>,
        binutils <binutils@sourceware.org>,
        Prasun Kapoor <prasun.kapoor@caviumnetworks.com>
Subject: Re: RFC: A new MIPS64 ABI
References: <4D5990A4.2050308__41923.1521235362$1297715435$gmane$org@caviumnetworks.com>
Date:   Mon, 21 Feb 2011 19:45:41 +0000
In-Reply-To: <4D5990A4.2050308__41923.1521235362$1297715435$gmane$org@caviumnetworks.com>
        (David Daney's message of "Mon, 14 Feb 2011 12:29:24 -0800")
Message-ID: <87hbbxqihm.fsf@firetop.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <rdsandiford@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29236
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdsandiford@googlemail.com
Precedence: bulk
X-list: linux-mips

David Daney <ddaney@caviumnetworks.com> writes:
> Background:
>
> Current MIPS 32-bit ABIs (both o32 and n32) are restricted to 2GB of
> user virtual memory space.  This is due the way MIPS32 memory space is
> segmented.  Only the range from 0..2^31-1 is available.  Pointer
> values are always sign extended.
>
> Because there are not already enough MIPS ABIs, I present the ...
>
> Proposal: A new ABI to support 4GB of address space with 32-bit
> pointers.

FWIW, I'd be happy to see this go into GCC.

Richard
