Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 22:03:00 +0100 (CET)
Received: from mail-io0-f173.google.com ([209.85.223.173]:36529 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011629AbbJ0VC6KLBdJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2015 22:02:58 +0100
Received: by ioll68 with SMTP id l68so237208042iol.3;
        Tue, 27 Oct 2015 14:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6rj4DwWsfybvbvjgNjnxvO5NnBOu5/ApU50CGCb052k=;
        b=xrsbhgGESaH1IAD9Vr4nj9P2c681H1aOx2vh6wRBTxPF6BOdwsNqAO1ItxXWkX+jUF
         eK/nTVTxjavAD1vmX5VYaJIx1zDH3Uta3GclnAOgYCXQ/njlMGbo7Dx5bTnQ6OQJ0KnW
         iDteiqpiG2is8MaWNAVWZ3BFpD8vopk3SxMVXBLY3SgfiX7YO5wkqo8s37rVH4qP/3/D
         OmXBFP/KJzVgC1ffSvcPoAUDwNT7J+jVzqc3+XJtXqZIckz8TZkA3IlzcNdt8ae8SrIH
         ggiMcRHGonoAn3bVQ/PvyNngkJgWO/9N/AiXBR7nzLWaV+eFrIwPacNtKZLLADyvGDOq
         gSVA==
X-Received: by 10.107.27.3 with SMTP id b3mr16921579iob.20.1445979772313;
        Tue, 27 Oct 2015 14:02:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.googlemail.com with ESMTPSA id 184sm6092371ioe.21.2015.10.27.14.02.50
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 14:02:50 -0700 (PDT)
Message-ID: <562FE678.2030307@gmail.com>
Date:   Tue, 27 Oct 2015 14:02:48 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Alex Smith <alex.smith@imgtec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [v3, 3/3] MIPS: VDSO: Add implementations of gettimeofday() and
 clock_gettime()
References: <1445417864-31453-1-git-send-email-markos.chandras@imgtec.com> <5629904A.2070400@imgtec.com> <20151027144748.GA23785@linux-mips.org> <562FE29C.8040106@imgtec.com>
In-Reply-To: <562FE29C.8040106@imgtec.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49724
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

On 10/27/2015 01:46 PM, Leonid Yegoshin wrote:
[...]
>
> And finally. clock scaling - what we would do if there are two CPUs with
> different clock ratios in system? It seems like common kernel timing
> subsystem can handle that.
>

The code that executes in userspace must have access to a consistent 
clock source.  If you are running on a SMP system that doesn't have 
synchronized CP0.Count registers, then your gettimeofday() cannot use 
CP0.Count (RDHWR $2).

As far as I know, CP0.Count is the only available counter visible to 
userspace, so you would have to disable the accelerated versions of 
gettimeofday() where you cannot assert that the counters are always 
synchronized.

David Daney
