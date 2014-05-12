Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2014 13:21:41 +0200 (CEST)
Received: from mail-bn1bn0109.outbound.protection.outlook.com ([157.56.110.109]:61668
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822286AbaELLVfWxvX4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 May 2014 13:21:35 +0200
Received: from alberich (2.174.248.214) by
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Mon, 12 May 2014 11:21:26 +0000
Date:   Mon, 12 May 2014 13:21:11 +0200
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Pekka Enberg <penberg@kernel.org>,
        David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 11/11] kvm tools: Modify term_putc to write more than one
 char
Message-ID: <20140512112111.GE15623@alberich>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <1399391491-5021-12-git-send-email-andreas.herrmann@caviumnetworks.com>
 <536A5826.6010008@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <536A5826.6010008@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [2.174.248.214]
X-ClientProxiedBy: AM2PR06CA010.eurprd06.prod.outlook.com (10.255.61.27) To
 BN1PR07MB389.namprd07.prod.outlook.com (10.141.58.141)
X-Forefront-PRVS: 0209425D0A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(377424004)(51704005)(24454002)(164054003)(81342001)(86362001)(85852003)(21056001)(79102001)(80022001)(92566001)(66066001)(92726001)(83072002)(83506001)(64706001)(46102001)(42186004)(77982001)(101416001)(20776003)(47776003)(50466002)(87976001)(99396002)(76176999)(54356999)(4396001)(50986999)(23676002)(74662001)(74502001)(31966008)(76482001)(19580405001)(81542001)(33656001)(33716001)(83322001)(19580395003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN1PR07MB389;H:alberich;FPR:;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

On Wed, May 07, 2014 at 07:58:30PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 06-05-2014 19:51, Andreas Herrmann wrote:
> 
> >From: David Daney <david.daney@cavium.com>
> 
> >It is a performance enhancement. When running in a simulator, each
> >system call to write a character takes a lot of time.  Batching them
> >up decreases the overhead (in the root kernel) of each virtio console
> >write.
> 
> >Signed-off-by: David Daney <david.daney@cavium.com>
> >Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> >---
> >  tools/kvm/term.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> >diff --git a/tools/kvm/term.c b/tools/kvm/term.c
> >index 3de410b..b153eed 100644
> >--- a/tools/kvm/term.c
> >+++ b/tools/kvm/term.c
> >@@ -52,11 +52,14 @@ int term_getc(struct kvm *kvm, int term)
> >  int term_putc(char *addr, int cnt, int term)
> >  {
> >  	int ret;
> >+	int num_remaining = cnt;
> >
> >-	while (cnt--) {
> >-		ret = write(term_fds[term][TERM_FD_OUT], addr++, 1);
> >+	while (num_remaining) {
> >+		ret = write(term_fds[term][TERM_FD_OUT], addr, num_remaining);
> >  		if (ret < 0)
> >  			return 0;
> 
>    Perhaps 'return cnt - num_remaining' instead?

Although all current callers of this function are not checking the
return value I aggree that this change would be nice to have.

I wouldn't make this change within this patch though.
(I'll add a separate patch to modify the return value.)

> >+		num_remaining -= ret;
> >+		addr += ret;
> >  	}
> >
> >  	return cnt;
> 
> WBR, Sergei


Thanks,
Andreas
