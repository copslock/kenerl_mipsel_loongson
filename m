Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 May 2013 19:40:46 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:36884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835083Ab3E2Rk1Tg5mk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 May 2013 19:40:27 +0200
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4THeGEn029092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 29 May 2013 13:40:16 -0400
Received: from tranklukator.brq.redhat.com (dhcp-1-192.brq.redhat.com [10.34.1.192])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r4THeD4d010719;
        Wed, 29 May 2013 13:40:14 -0400
Received: by tranklukator.brq.redhat.com (nbSMTP-1.00) for uid 500
        oleg@redhat.com; Wed, 29 May 2013 19:36:37 +0200 (CEST)
Date:   Wed, 29 May 2013 19:36:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH] kernel/signal.c: avoid BUG_ON with SIG128 (MIPS)
Message-ID: <20130529173634.GA2020@redhat.com>
References: <1369846916-13202-1-git-send-email-james.hogan@imgtec.com> <51A638A4.2000705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51A638A4.2000705@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.23
Return-Path: <oleg@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: oleg@redhat.com
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

On 05/29, David Daney wrote:
>
> On 05/29/2013 10:01 AM, James Hogan wrote:
>> MIPS has 128 signals, the highest of which has the number 128. The
>
> I wonder if we should change the ABI and reduce the number of signals to
> 127 instead of this patch.

Same thoughts...

>> @@ -2366,8 +2366,12 @@ relock:
>>
>>   		/*
>>   		 * Death signals, no core dump.
>> +		 *
>> +		 * MIPS has a signal number 128 which clashes with the core dump
>> +		 * bit. If this was the signal we still want to report a valid
>> +		 * exit code, so round it down to 127.
>>   		 */
>> -		do_group_exit(info->si_signo);
>> +		do_group_exit(min(info->si_signo, 127));

This avoids BUG_ON() but obviously fools WIFSIGNALED(), doesn't look
very nice.

Oleg.
