Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 12:15:41 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:40375 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27029575AbcEQKPjTVWzF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 May 2016 12:15:39 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E93C86264E;
        Tue, 17 May 2016 10:15:31 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4HAFTd8011984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 17 May 2016 06:15:30 -0400
Subject: Re: Endless loop on execution attempt on non-executable page
To:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Hill, Steven" <Steven.Hill@caviumnetworks.com>
References: <57345F0D.9070503@redhat.com>
 <20160512125342.GS16402@linux-mips.org>
 <9af052f6-b50c-7ba5-ebbb-0bdff0c58dd9@redhat.com>
 <20160512142306.GT16402@linux-mips.org> <5734A7D8.9030407@gmail.com>
Cc:     linux-mips@linux-mips.org
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <4c6e84e7-fa29-2baf-44ac-4d4aa0cb1bdd@redhat.com>
Date:   Tue, 17 May 2016 12:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <5734A7D8.9030407@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 17 May 2016 10:15:32 +0000 (UTC)
Return-Path: <fweimer@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweimer@redhat.com
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

On 05/12/2016 05:57 PM, David Daney wrote:

> This is something that would be easy to diagnose on the OCTEON simulator...
>
> Before spending time doing that, has anyone tried this on current
> kernels rather than the 3.14 indicated above?

I can't swap kernels on this device, and I suspect it's running a vendor 
kernel for a reason (lack of Debian/upstream support, presumably). 
Sorry about that.

Florian
