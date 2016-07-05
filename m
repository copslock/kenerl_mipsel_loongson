Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 15:56:48 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:35962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992993AbcGEN4lz4MDl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jul 2016 15:56:41 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 072F8C049D58;
        Tue,  5 Jul 2016 13:56:36 +0000 (UTC)
Received: from [10.36.112.53] (ovpn-112-53.ams2.redhat.com [10.36.112.53])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u65DuWjk017500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 5 Jul 2016 09:56:33 -0400
Subject: Re: [PATCH 01/14] MIPS: uasm: Add CFC1/CTC1 instructions
To:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
 <1466699687-24791-2-git-send-email-james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f659139-ff8a-0291-eec3-9279d4ee9d60@redhat.com>
Date:   Tue, 5 Jul 2016 15:56:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <1466699687-24791-2-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 05 Jul 2016 13:56:36 +0000 (UTC)
Return-Path: <pbonzini@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54223
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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



On 23/06/2016 18:34, James Hogan wrote:
> diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
> index ad718debc35a..4731893db3f7 100644
> --- a/arch/mips/mm/uasm.c
> +++ b/arch/mips/mm/uasm.c
> @@ -49,18 +49,18 @@ enum opcode {

This "enum opcode" looks like a pretty bad conflict magnet.  Ralf, can
you check if you have any patches affecting it too?

Paolo
