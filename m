Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2011 03:53:07 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:21012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903717Ab1LLCw6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Dec 2011 03:52:58 +0100
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBC2qmK9019456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Sun, 11 Dec 2011 21:52:48 -0500
Received: from [10.67.4.31] (vpn1-4-31.sin2.redhat.com [10.67.4.31])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id pBC2qZ41006827;
        Sun, 11 Dec 2011 21:52:39 -0500
Message-ID: <4EE56C67.2060909@redhat.com>
Date:   Mon, 12 Dec 2011 10:52:23 +0800
From:   Cong Wang <amwang@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111108 Fedora/3.1.16-1.fc14 Thunderbird/3.1.16
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Kosina <jkosina@suse.cz>,
        Kevin Cernekee <cernekee@gmail.com>,
        "Justin P. Mattock" <justinmattock@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 04/62] mips: remove the second argument of k[un]map_atomic()
References: <1322371662-26166-1-git-send-email-amwang@redhat.com> <1322371662-26166-5-git-send-email-amwang@redhat.com> <20111209160639.GA30988@linux-mips.org>
In-Reply-To: <20111209160639.GA30988@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
X-archive-position: 32085
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amwang@redhat.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8783

于 2011年12月10日 00:06, Ralf Baechle 写道:
> On Sun, Nov 27, 2011 at 01:26:44PM +0800, Cong Wang wrote:
>
> Acked-by: Ralf Baechle<ralf@linux-mips.org>
>
> I assume you want to merge this patch as part of a single series?
>

I put all the patches into a single tree which is in linux-next now. :)

Thanks for review!
