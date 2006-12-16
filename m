Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Dec 2006 11:17:28 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.170]:58513 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20038404AbWLPLRY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 16 Dec 2006 11:17:24 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1309093uga
        for <linux-mips@linux-mips.org>; Sat, 16 Dec 2006 03:17:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X+XJs0KS7Cnke3rm8I5iC1sXWGfFTH1hvlCW8pz9vthEMHjKCJ2sF55Cde+/dWKicOqqAnNgK4zDE+DBxmVQecF4hDUWMZ5gDAneAMjLu64DGuzobx25LLTDjUuHsywfKIMrerWWd+CVsUU23QHrhyp5wf5ls5Zswk5L+uUXpdI=
Received: by 10.78.193.19 with SMTP id q19mr956483huf.1166267843605;
        Sat, 16 Dec 2006 03:17:23 -0800 (PST)
Received: by 10.78.124.19 with HTTP; Sat, 16 Dec 2006 03:17:23 -0800 (PST)
Message-ID: <cda58cb80612160317n2547cbf4q39a8e184449faf40@mail.gmail.com>
Date:	Sat, 16 Dec 2006 12:17:23 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [RFC] FLATMEM: allow memory to start at pfn != 0
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20061211184640.GB1308@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1165420110699-git-send-email-fbuihuu@gmail.com>
	 <20061211184640.GB1308@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 12/11/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Dec 06, 2006 at 04:48:27PM +0100, Franck Bui-Huu wrote:
>
> I just tested this on a Malta.  So patch 2/3 makes Malta die pretty
> spectacularly, so I'm going to remve patches 2/3 and 3/3 again from my
> tree.
>

When you'll have time, could you test only patch 2/3. It's only a
clean up patch, which eases integration of patch 3/3 ? This clean up
should improve current code even if you don't merge patch 3/3. And
more importantly,  knowing that patch 2/3 woks should help me to find
out what's wrong with your config.

Thanks
                Franck
