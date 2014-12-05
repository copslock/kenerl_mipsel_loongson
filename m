Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2014 20:44:16 +0100 (CET)
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:56791 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008215AbaLEToOfHX96 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Dec 2014 20:44:14 +0100
Received: from resomta-po-13v.sys.comcast.net ([96.114.154.237])
        by resqmta-po-08v.sys.comcast.net with comcast
        id Pvjy1p00257bBgG01vk8yX; Fri, 05 Dec 2014 19:44:08 +0000
Received: from gentwo.org ([98.213.233.247])
        by resomta-po-13v.sys.comcast.net with comcast
        id Pvk31p00C5Lw0ES01vk3De; Fri, 05 Dec 2014 19:44:08 +0000
Received: by gentwo.org (Postfix, from userid 1001)
        id 59D329D5; Fri,  5 Dec 2014 13:44:03 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 57E881A4;
        Fri,  5 Dec 2014 13:44:03 -0600 (CST)
Date:   Fri, 5 Dec 2014 13:44:03 -0600 (CST)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@gentwo.org
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Kees Cook <keescook@chromium.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Zubair.Kakakhel@imgtec.com, geert+renesas@glider.be,
        david.daney@cavium.com, Peter Zijlstra <peterz@infradead.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        davidlohr@hp.com, "Maciej W. Rozycki" <macro@linux-mips.org>,
        chenhc@lemote.com, Ingo Molnar <mingo@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        =?ISO-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
        Tejun Heo <tj@kernel.org>, alex@alex-smith.me.uk,
        Paolo Bonzini <pbonzini@redhat.com>,
        John Crispin <blogic@openwrt.org>,
        Paul Burton <paul.burton@imgtec.com>, qais.yousef@imgtec.com,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        dengcheng.zhu@imgtec.com, manuel.lauss@gmail.com,
        lars.persson@axis.com
Subject: Re: [PATCH v3 3/3] MIPS: set stack/data protection as
 non-executable
In-Reply-To: <54820244.5010304@gmail.com>
Message-ID: <alpine.DEB.2.11.1412051343330.5206@gentwo.org>
References: <20141203015537.13886.50830.stgit@linux-yegoshin> <20141203015824.13886.74616.stgit@linux-yegoshin> <5481EB52.6060706@gmail.com> <CAGXu5jJJx0O7GhHghy+sC4fJL2O=RsO+Zgm78r9SNt-aTbhqcw@mail.gmail.com> <54820244.5010304@gmail.com>
Content-Type: TEXT/PLAIN; charset=US-ASCII
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1417808648;
        bh=M0hVFfPTLI1lGDpzyXAwhSCSvIiPZBgkLJnDm1skwXE=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Content-Type;
        b=G6cDofa/q8FIqJhxOtUrtFlSYwG84UYq8ssn+7TJx4iQoBHjqTpiUjFmX9JhkE0LU
         a5+L/SadsZNoDlpyiapent+JP33auXEf80hdGvZ2vyI7mWk6Yf0ezgF5RrneF/PyMp
         j9NW8HzxNVQnqISupLU5jrnW0R+DWc49hx8pFuTyHWUYKNEGI+ladeMMvhHXpmnQUd
         UVYn9iL/YLYgR7GB4zrMNt+vKjEBR00hMPY0KgdFoninZhHUZIKL9JdW+CSvGmotYE
         oa+JehBdw3hW30E8ntZxrZ7Zi5hwMO1DBvS9YN58ptiypUDIrvLbEwRGrO+FLGU5tk
         fflufQDcd6OAg==
Return-Path: <cl@linux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44590
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cl@linux.com
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

On Fri, 5 Dec 2014, David Daney wrote:

> The problem is not with "modern" executables that are properly annotated with
> PT_GNU_STACK.
>
> My objection is to the intentional breaking of old executables that have no
> PT_GNU_STACK annotation, but require an executable stack.  Since we usually
> try not to break userspace, we cannot merge a patch like this one.

How old are these and how many are still around? Can the annotation be
added with a tool?
