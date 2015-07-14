Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 03:26:21 +0200 (CEST)
Received: from out02.mta.xmission.com ([166.70.13.232]:58322 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008848AbbGNB0TUGPDG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 03:26:19 +0200
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZEoz3-00081Z-Gb; Mon, 13 Jul 2015 19:26:09 -0600
Received: from 67-3-205-90.omah.qwest.net ([67.3.205.90] helo=x220.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <ebiederm@xmission.com>)
        id 1ZEoz2-00020c-LT; Mon, 13 Jul 2015 19:26:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     dwalker@fifo99.com
Cc:     Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>, linux-mips@linux-mips.org,
        Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
        linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20150710113331.4368.10495.stgit@softrs>
        <20150710113331.4368.63745.stgit@softrs>
        <87wpy82kqf.fsf@x220.int.ebiederm.org>
        <20150713202611.GA16525@fifo99.com>
Date:   Mon, 13 Jul 2015 20:19:45 -0500
In-Reply-To: <20150713202611.GA16525@fifo99.com> (dwalker@fifo99.com's message
        of "Mon, 13 Jul 2015 20:26:11 +0000")
Message-ID: <87h9p7r0we.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-AID: U2FsdGVkX1+FD7+8LZcDabzlAKJqpFB6WaD4DnK0xEA=
X-SA-Exim-Connect-IP: 67.3.205.90
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is not available
X-SA-Exim-Version: 4.2.1 (built Wed, 24 Sep 2014 11:00:52 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Return-Path: <ebiederm@xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
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

dwalker@fifo99.com writes:

> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>> 
>> > You can call panic notifiers and kmsg dumpers before kdump by
>> > specifying "crash_kexec_post_notifiers" as a boot parameter.
>> > However, it doesn't make sense if kdump is not available.  In that
>> > case, disable "crash_kexec_post_notifiers" boot parameter so that
>> > you can't change the value of the parameter.
>> 
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> I think it would make sense if he just replaced "kdump" with "kexec".

It would be less insane, however it still makes no sense as without
kexec on panic support crash_kexec is a noop.  So the value of the
seeting makes no difference.

Eric
