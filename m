Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Apr 2012 18:07:54 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61117 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903680Ab2DYQHi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Apr 2012 18:07:38 +0200
Received: by pbbrq13 with SMTP id rq13so1754138pbb.36
        for <multiple recipients>; Wed, 25 Apr 2012 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=B46n38/XA4eYc36nkVhpdTf50ReTtnn7X+49A2J0TWk=;
        b=EJPxyjj/BShFsKOqlt6OGGP0rqK+HvEcR7r4rzy5jxtXbyv8SsxfDnfVQpIvMGnAJc
         RtxQoyqmc7r+cDCPCoNWb27KPD/tarzuvmLxUk1ZS56jQ0OabPP93uH0CDya1fQfOO5C
         uYcqvdkHlh12nC+1SiZjvlUiUd3UdgzYq55DuHxfqw+5CPMdAnqBHCLeBBp+dJ4oJaZX
         WbTOf4nPdV6YGCmgFF9/pVHF5WTA7pfcO0CVvzucJgtXE3Zsk6URcVt7RDiVxXT2YX8n
         /JH2JWitnt1BpehULs3hE65HNUxGfoYJVDgH3pVDbbgSbQfu3IksWHPCGQ3dhgm2Bc31
         uJrg==
Received: by 10.68.201.9 with SMTP id jw9mr8063111pbc.88.1335370051232;
        Wed, 25 Apr 2012 09:07:31 -0700 (PDT)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id wf6sm489654pbc.8.2012.04.25.09.07.29
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 09:07:29 -0700 (PDT)
Message-ID: <4F982140.8000008@gmail.com>
Date:   Wed, 25 Apr 2012 09:07:28 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Hillf Danton <dhillf@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: Add support for transparent huge page
References: <CAJd=RBAXc+QSX+xnJ2W9vVwK64Etrzrr=iBqPkJXNvYgwujQ_Q@mail.gmail.com>        <4F9736C9.8020003@gmail.com> <CAJd=RBBcWKQC+YoCrpvPJ78jZoytj=t6oeybdR=t_r_DCfGhLQ@mail.gmail.com>
In-Reply-To: <CAJd=RBBcWKQC+YoCrpvPJ78jZoytj=t6oeybdR=t_r_DCfGhLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 33013
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/25/2012 06:58 AM, Hillf Danton wrote:
> On Wed, Apr 25, 2012 at 7:27 AM, David Daney<ddaney.cavm@gmail.com>  wrote:
>>
>> I'm not sure where that copyright came from.
>>
> You ported hugetlb to MIPS, and I C hello to the author that way:)
>

Really, I think the best policy is to retain copyright messages added by 
others, but don't invent new ones attributed to others.

David Daney
