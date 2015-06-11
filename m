Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Jun 2015 08:25:05 +0200 (CEST)
Received: from mail-wg0-f42.google.com ([74.125.82.42]:34894 "EHLO
        mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006823AbbFKGZCrag7k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Jun 2015 08:25:02 +0200
Received: by wgme6 with SMTP id e6so48516288wgm.2;
        Wed, 10 Jun 2015 23:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iTd/S/NNL0CgqscGnx0sQsCtIvyaxQpYqgzlPybw7iY=;
        b=NA4nskahf0Sc4cpROMLSeKg5EnNhDbPKlUzzWR43Ivm8/++zPc5r75skGE7D1bFcVe
         4nGHP010KhluP5ABqOtj/e82hbFuBPzX9jhl18T4wgoqd1rzwJss4Ci2daIqxUTmbfd7
         O5BoFrB6KqKeDroaZOwRORmQJ1ICu2H1ysvOjb0fL2N9lasai50ahAMrA8Yeb9fF8eQJ
         d7RV+vfV0w0PYb1gl+OByNefMMxmdB6hZZ4/aXM9AVhuLYOF8gtriHKX0BOo8aH+760W
         rIXeZT3/S513F9XXrjCZo8lGqLwQaIyDrb1/rrq04TgYCS+Lo7A1BTiQrp+7aRHjK+yn
         j+Fg==
X-Received: by 10.194.100.42 with SMTP id ev10mr12924983wjb.50.1434003897645;
        Wed, 10 Jun 2015 23:24:57 -0700 (PDT)
Received: from gmail.com (54033495.catv.pool.telekom.hu. [84.3.52.149])
        by mx.google.com with ESMTPSA id gs7sm11210664wib.10.2015.06.10.23.24.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2015 23:24:55 -0700 (PDT)
Date:   Thu, 11 Jun 2015 08:24:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Generic kernel features that need architecture(mips) support
Message-ID: <20150611062452.GB32133@gmail.com>
References: <55759543.1010408@gmail.com>
 <20150610145804.GG2753@linux-mips.org>
 <5578679D.2030307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5578679D.2030307@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <mingo.kernel.org@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mingo@kernel.org
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


(Jon Cc:-ed)

* Xose Vazquez Perez <xose.vazquez@gmail.com> wrote:

> On 06/10/2015 04:58 PM, Ralf Baechle wrote:
> 
> > How are the documentation files in Documentation/features/ maintained?
> > They were automatically generated so I wonder if I have to take care
> > of anything.
> 
> CC: Ingo and related ml.

So changes to Documentation/features/ should come as simple patches done from hand 
editing, there's no need to preserve any initial (half-)automated generation. 
Formatting should be preserved so that Documentation/features/list-arch.sh still 
works as before.

Jon: would you like to receive all patches to Documentation/features/ so you can 
collect them in the documentation tree, or can maintainers patch it as part of any 
feature work that affects the tables? I think it's all finegrained enough to not 
create conflicts. That way they would become partly self-maintaining. (Or at least 
one can always hope! ;-)

Thanks,

	Ingo
