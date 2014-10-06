Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 01:49:09 +0200 (CEST)
Received: from mail-bn1bon0088.outbound.protection.outlook.com ([157.56.111.88]:56288
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010553AbaJFXtINcAKH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Oct 2014 01:49:08 +0200
Received: from dl.caveonetworks.com (64.2.3.195) by
 DM2PR07MB590.namprd07.prod.outlook.com (10.141.176.140) with Microsoft SMTP
 Server (TLS) id 15.0.1044.10; Mon, 6 Oct 2014 23:49:00 +0000
Message-ID: <54332A64.5020605@caviumnetworks.com>
Date:   Mon, 6 Oct 2014 16:48:52 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Rich Felker <dalias@libc.org>, David Daney <ddaney.cavm@gmail.com>,
        <libc-alpha@sourceware.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@linux-mips.org>, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
References: <1412627010-4311-1-git-send-email-ddaney.cavm@gmail.com> <20141006205459.GZ23797@brightrain.aerifal.cx> <5433071B.4050606@caviumnetworks.com> <20141006213101.GA23797@brightrain.aerifal.cx> <54330D79.80102@caviumnetworks.com> <20141006215813.GB23797@brightrain.aerifal.cx> <543327E7.4020608@amacapital.net>
In-Reply-To: <543327E7.4020608@amacapital.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [64.2.3.195]
X-ClientProxiedBy: BN1PR07CA0041.namprd07.prod.outlook.com (10.255.193.16) To
 DM2PR07MB590.namprd07.prod.outlook.com (10.141.176.140)
X-Microsoft-Antispam: UriScan:;
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:;SRVR:DM2PR07MB590;
X-Forefront-PRVS: 03569407CC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6009001)(479174003)(377454003)(189002)(199003)(24454002)(51704005)(66066001)(53416004)(20776003)(42186005)(54356999)(23746002)(87266999)(85852003)(65806001)(50986999)(110136001)(65956001)(65816999)(92566001)(122386002)(76176999)(21056001)(50466002)(46102003)(99136001)(92726001)(87976001)(31966008)(83506001)(69596002)(97736003)(101416001)(33656002)(102836001)(93886004)(80316001)(4396001)(85306004)(95666004)(36756003)(47776003)(76482002)(80022003)(120916001)(106356001)(105586002)(77096002)(99396003)(10300001)(107046002)(40100002)(81156004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR07MB590;H:dl.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-OriginatorOrg: caviumnetworks.com
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
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

On 10/06/2014 04:38 PM, Andy Lutomirski wrote:
> On 10/06/2014 02:58 PM, Rich Felker wrote:
>> On Mon, Oct 06, 2014 at 02:45:29PM -0700, David Daney wrote:
[...]
>> This is a huge ill-designed mess.
>
> Amen.
>
> Can the kernel not just emulate the instructions directly?

In theory it could, but since there can be implementation defined 
instructions, there is no way to achieve full instruction set coverage 
for all possible machines.

>  Can it single-step through them in place?

No.  If it could, we wouldn't be having this informative discussion.
