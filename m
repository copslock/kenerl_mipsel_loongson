Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Feb 2017 23:21:42 +0100 (CET)
Received: from mail-cys01nam02on0074.outbound.protection.outlook.com ([104.47.37.74]:53209
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992178AbdB0WVffBgc9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Feb 2017 23:21:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TyLOY07O92w1FDYtC0adfK7E/4WPXuMYFdXBYgrXrik=;
 b=KbTo91z8mlWBlVbyRS+3JuGH7RDhHyA5+knIFT4q4RdktRmjFqv7Q7TFP8d0MqKaSG/vUDhorsPw+/VWTOrRUveE4D5X79DsCRLUTUOCOjyV2Tir8oNZYKonE6hrJ9PfBn9sFB98n7QUEvxpC7PGg7x+9lYXOxsMLZsUwwAazIY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 BL2PR07MB2417.namprd07.prod.outlook.com (10.167.101.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.933.12; Mon, 27 Feb 2017 22:21:25 +0000
Subject: Re: [PATCH] jump_label: align jump_entry table to at least 4-bytes
To:     Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
References: <1488221364-13905-1-git-send-email-jbaron@akamai.com>
 <f7532548-7007-1a32-f669-4520792805b3@caviumnetworks.com>
 <93219edf-0f6d-5cc7-309c-c998f16fe7ac@akamai.com>
 <aa139c18-1b04-2c20-2e22-89d74503b3cf@caviumnetworks.com>
 <20170227160601.5b79a1fe@gandalf.local.home>
 <6db89a8d-6053-51d1-5fd4-bae0179a5ebd@caviumnetworks.com>
 <20170227170911.2280ca3e@gandalf.local.home>
Cc:     Jason Baron <jbaron@akamai.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anton Blanchard <anton@samba.org>,
        Rabin Vincent <rabin@rab.in>,
        Russell King <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Zhigang Lu <zlu@ezchip.com>
From:   David Daney <ddaney@caviumnetworks.com>
Message-ID: <7fa95eea-20be-611c-2b63-fca600779465@caviumnetworks.com>
Date:   Mon, 27 Feb 2017 14:21:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170227170911.2280ca3e@gandalf.local.home>
Content-Type: multipart/mixed;
 boundary="------------D566EBDEDAFBEDE0F1C637BC"
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: MWHPR07CA0042.namprd07.prod.outlook.com (10.169.230.28) To
 BL2PR07MB2417.namprd07.prod.outlook.com (10.167.101.141)
X-MS-Office365-Filtering-Correlation-Id: 1374d8a0-fb5f-471e-1094-08d45f5ef8c2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BL2PR07MB2417;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;3:iefQaMUW5EPco++0BdMecYTJWERlHIKlAmDf9gbtt8dxo1WZFjAWTD+yeTM8FXQrIAPujBI19kjjysbCKg5M2XwEroPc5odmNyLqdcci/H8L5NgA45RIeG0fcyrddAir9F1m9zNjFQD+XptmpzDU27jSJTfYSzxhDmeh8QtoaHAwiFXpACdvByY1LHyOSjddGhgzo9flJZAxlDinBlcA5//Ukj204wUiKxLsxOB4hm9XFkfevX847t8MoVDiDL3Y8vAb3C5qRqKWUMYAiUuOxQ==;25:rZUvClGPCroH4b3D6OQ/SAl3KiTwoj/cFq63XJXqugE6rNNuVKtPrt7hocaMRWwiCWy/UyJehsWqz7orllNwHqNavL+/P2uymnyxxDNZeSLHHRVgXkevpi3ckzxYs//2uCtvHk3Dto/2P8SDiwUegS4eS3Tw16DNlmEhRUOAwaLEvYUVonLTyOnqEonulQL00aJSDxTzR20NiWz7PuCsmZA5+B9TIUNIsrRn/lLgo8eGc+0AkhKT4TMt6k6H+civA+N9UUAXIY5Q62W0j/TUmZHycMl5xDVG2TnACGAGJ0xQhCtesnJVXudv6sJm1gtkzfFurRrAgodoT5qUp04S1KHpk5UMv9NaNeomfxvN+QiM98XPfvkZkA7XOG4fWP0IYARky7LeFESdwmwtckEiOpG1xQpPAF5/lKR5zbZl1OmtTEkFLbOPN8kxCvK3P8Aj295lykF2rxs6RCrC9jnOne62begwZa8A3AZsd6T2tRdALzfeL+PH93Xz7IZBjrMI
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;31:aZXlR9ddQos3FIwAXS8/LDdGbcLen+C4SjauoqkxGxFN6kT4NGcIHflYLcKIP/pbMF5Ic6I8zKSMfNid6vb0YUnZV0sMFpRH7ib9gjdNYzoboM0RVS3lMC0YslW2PfuVUt7MFmYCkPkjcH8RqfSmZUZMKSTobDAYSjFyemdwZE4Bqwbk4vKzaO0ZzJBgV1WCKkO+9PfrVSJlvQOzqdJ1cg4MjKLzhUVmmw8ZDx0TxJUAMGk0eDauOYqHn4KnZkzFvLMF+nCW2Hu1B1Xnq3QMCTYmiJYIwt3ng6qLzz9kYlFEsoUP93PfUkIM8SgtEFbdRrBhSJKxWT+wMMH5K0uBEg==
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;20:UPmhxciMX9eI7Nztgca/w0PBcoUddN3LoW5/TcAM2uAqaq3LtCMK0v+0sKzbbrfe6QoOB+2uBsbRei/fZwVyZGda5LpITpkOvV7LwSy/eUJ79+1xGJPEXvPvbLZEYUHgy8AAUhgKllAW0w/I/U6StkCuhLMCbw8p+LrVUD7YiRdq4++bSBwt99Dfu7nfE3ULUSPgV8VjkDMa8diJbxCprcVYnn+XpfH+/Zysw27qtTghA5HNjnx2YCJ4GkGZ2btbK3j7hcEhFm72wP8Lkxc+hwXou+l5GcyERFBzD9+u08lv320ga1qP9Lb9m3w3PsdFMMj/kv3SR4KfeP9UmQhFe/zzCNpXBo1o79AQVVw+ryGO+Dw2eO+N8+Qhy+W7DiiD5zqhQkegzjr5Ve6G/FxImrFlFPbdUanO+mXG0jmPkFEKus7+fkzDZxeIzWbohhH/RAQYKi1CmlBRRJWztx9icD/z/7eI4EplcMRV/1QAOJmCv3w7cC5QKJHzRD52njcZM83pb5yeS8tcj90LL8wrlIph5ZJhoSIlw3qB5tCsTRzVvymAeh6HGYaAuTUV5yQoEnkfH5zq9lgXJOa18SAsVy0fZARvkFXKf0Yfpqvt77c=
X-Microsoft-Antispam-PRVS: <BL2PR07MB241728468239BC4737DDE64B97570@BL2PR07MB2417.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(102415395)(6040375)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001)(6041248)(20161123555025)(20161123560025)(20161123564025)(20161123562025)(20161123558025)(6072148);SRVR:BL2PR07MB2417;BCL:0;PCL:0;RULEID:;SRVR:BL2PR07MB2417;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;4:4Cifc4p05CgGVBePIsyf26AOyKBuRqOf8TGoVGqxOVukZc1s/ZPWvZ9me9grw2eaBGlgmdaMYW5xSLxy8lTfBaB79GWh/vMlafpIRtk8mHAjGVFSW4zKq/3a7S75n17yVYY+UTX0pjwevq5/zf/z/5eMbtvbCB1jAUx3JHFENQrfAORlaRSK+y0lEMJYH3BAfMu+C4+ZozptcWNax6wtVLI5/Pk/qeJ3SdTdl3wIfzEwLt3zTysBAPGT9oIcUaRhOVTbo0hlF8eSbGi1+znTL8ef2IRavwK/cBWWjCzpFIGTVlaRk9Q0uVAuRO/lPM7lvD8w+cc15V5Q/O2/2WPVKFY+pjV+R9cLjMkStkIuDrkgbd8LXz3hGM8qIePEYaxYJAdmgYzjR+PCFUJgzYjwoiwMMPH28CP6HStrogJCFGDOFme+5ST/1JeTgLXdl2HExFq6dFfZJmrIH4Ni5J8ehQmv1I+WUm+Vh/qhFnrYyr7KA/vkhxosknWlVn9b7WnIxqa1i8n63jOjhxGuDSTUu1owkMuJHSLmet32pG+PNScaQABix4jbotUZldPfhewa59+vfmyjWf9WkjXbURy0qD+uFx9R1G303HS0DCPuuzxGBNV+COFHCY2XEVdp59t0
X-Forefront-PRVS: 02318D10FB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(7916002)(39450400003)(24454002)(189002)(199003)(377454003)(101416001)(66066001)(65806001)(65956001)(76176999)(50986999)(54356999)(568964002)(189998001)(270700001)(6116002)(97736004)(68736007)(64126003)(4610100001)(5890100001)(2476003)(31696002)(36756003)(4001350100001)(3846002)(2906002)(65826007)(4326007)(42882006)(54906002)(81156014)(69596002)(229853002)(106356001)(6246003)(6666003)(38730400002)(83506001)(53546006)(6512007)(81166006)(7416002)(2950100002)(8676002)(6486002)(5660300001)(25786008)(6506006)(305945005)(84326002)(93886004)(7736002)(53416004)(31686004)(42186005)(105586002)(92566002)(53936002)(33646002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR07MB2417;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR07MB2417;23:vIONGLVZ/4DjuT7tiTvylJLfHc1FVup0WaDNiY03o?=
 =?us-ascii?Q?QdqQ6QVWaDZJfYEeMF2SSCwNdtBC+oF6OoGYSW5tAr64oGKJLu15Zm4BBapP?=
 =?us-ascii?Q?T5+jfBBuq5NxutVe188RcmM1zucwzOC3wfrjxzhMvFQv02DpsYwrFJuZIaTc?=
 =?us-ascii?Q?hYsIgh6+9qBefdyJzx9hmAf9iqAEq0GYNZFAYSLBvJ580CpYZEH9ZMslVQWj?=
 =?us-ascii?Q?4GWg4P1sEHZKHli9LvgIT2syxZfSohDNXWJp7HaxXDX2yjE9ziOkKomO6Np7?=
 =?us-ascii?Q?cECWmQ2qYnq29BfCHDU1+ITRDIPlTIoaLGngV20+c+YiEgsJl2cUk4+8J0Sj?=
 =?us-ascii?Q?6zaPcdbbMiQDPYAw8P7Dwp92D+RDMuv7O7CaFic2U9z9vUB7FlqLQkffMwqh?=
 =?us-ascii?Q?Y7XG6Zfe+CZB/uDP1XLZpnyRpHYi3/KsxOZy2O2AeU/wQLNCzTpefscoj2zO?=
 =?us-ascii?Q?e+Tw9rulIIq3wdME9sA0leM6GBIvjg5RLdUNT30RYXfd+ZjB7SLN5SLlCmRV?=
 =?us-ascii?Q?8Zw85/ECrxJokeLMg/cuN1FbXzKSx2xkYl4TrOWXHWWG2rw5KMm2PyenGt6V?=
 =?us-ascii?Q?tFO8We5nAcu+47ToH2cfNhraZCbjGLxzdC85q1b1BDsYfCIjyPvZSFIcJsT6?=
 =?us-ascii?Q?01fFlHIXmzzaIx0DtKo3S+Z3WVuOcYL0cs91NK0j+Z7Dr3+TI1GCie5MdeeL?=
 =?us-ascii?Q?Ae/giPSahdCIbkm5SIzeuHrAgtdSVcH5NC3i6zKfSGkI7TkPzIKKlbWhG/+v?=
 =?us-ascii?Q?TLzqHiAClWUbyoL6OnAc32Krjo6UCZaoFY6HrsnM++V7OqKlgtAK2qR0rwTL?=
 =?us-ascii?Q?vx7V8jw9RaKJs/43pz0ndLzokoy/LbGRq0QVUnJs8GCO+WhWoUrphXg3W+y8?=
 =?us-ascii?Q?IQsnD6/KBlLCjiEICi+Kf3o4M7oSvulvxfQOsPGEcG92LcF8QNlNBbQUEJ8F?=
 =?us-ascii?Q?zrTFKBFF13kJXDCWGmN9dWqjNVjU4ZaLzpQas3iST3KqrpVbN/G5/mdw7elY?=
 =?us-ascii?Q?ud1V/Pa99SR5xOjtA8BIZ91sn8fY9WS+rMT5XXW2D2UZ2dyXxjeO3PPSMQLg?=
 =?us-ascii?Q?NOe/AWQr33BtE8J0qwKzL28EOA6JcwhVdclued18t8udeMf7eTR+g007adBt?=
 =?us-ascii?Q?XQYZCJI7cdqGyB569/ol/+J/6JJFsxjsYxwGdL2QT9oMyUBxTGXGC74KFSrT?=
 =?us-ascii?Q?wAIVUYC5wdlolfy3r7C77EJ/e+U8dfOifHGoM2FNIV9mWn9AEWeO1kkCd1Ij?=
 =?us-ascii?Q?QZGN1yNHZ/TFf3Gh39X49QqMyvR5YqDL/sau9G2GlCGm35j7Xpy5kAtyZynD?=
 =?us-ascii?Q?XX3spVHFEgoBBCrfle1JTqXGqzPdxBSAoLQG0tHljcg7SAg5WWF7Pbpz1nWr?=
 =?us-ascii?Q?rzp6ixTwmnNVvasfVZD137Tsrk7PHn19HFVnGR3patP2kxUIxkTgBDN+JRiD?=
 =?us-ascii?Q?/sdWBd9IHS+HSNt7fQkaJbEdv+dyYibaAb47HrYGcRxr1JsjdHO/yFsviBKG?=
 =?us-ascii?Q?Hvr4Weq3LVb+3IO/JnTN6Hp8+oygTnlip8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;6:6Yc9urUqGxfLIsXGcWKMswlbbIjKUmz4yxNxTtR7dWpzRPQliA/vLw4fp8ieKYEdE/uU7TTtIaEpSOz//Bw9diJEZn/axnP6lt6wn7T2hFzO+dGhajBX458VjqsvO8WfSrD/FStHxE8tgdB1M+MA7KEYc1nfBqq/YYnQQ00henXnNP3Ci4a0Fl+PYjN2PTuUy5MiDw06IDafEI0RSevN+e55hHDS0z9KHet7sfvTtMZGEb9HB/0snwhSmbsPmdQWBKaWM5MgPKmpfnLDELaWYCyd1mQiREeesEmqWBkH5g0h26ae1xunrkKdzO3P6tr6ILUWoZKcf0DsfHYblGNjBrZ3Ynoh6Ze43t1Qtf5WQpOGDSevBl9V+P3XnZKZMdjVJVnjF9q2bzFC/xi8ttWrvQ==;5:uIVt1R4kVT6p1aLixrtmWasfw0YP0ScZ+5h4XKgg1Lsny6ESwrtN0X+6ANO9b2iGnCyCG5tpiTLlr1CsI0o/zGbKTw0gHCWEHw4SFZcsvxb45N09tS2/gapn9CIgPnU6/OPquCDcLRsarzKa1X7/iQ==;24:qi1rNiVuYwW8zczxM6zP+pt/A+BCqE98YfYP22zvlum/CKpe36V+tnpy7W23KqIu83GCEIwAKhIvz5V7mxLYLTM2IJrV+h/HYRlWWrwVEpA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR07MB2417;7:FNA038Zo2OIN6fc7yc3QdFya4kcevACZO7gbYXxSYY82Fni1mMlFPiiT+C4jL39NyWXOQUHXIrPj7hdMOkCDy57pHhKY6gclpg78xcUX1Qvs6vHnroNc9ALSu3ZpztNH1q4xntL0vN3WICcYHBwzcj428WSmhUxdon0s/kDO28jBdrGPZZaMzg3/ogyryR5283ib5MvOpzCMd42yiJ++dMMRlMYCzJ828C2oFtGOK+ENahGb3/8KGNneze/GkSNWWKRSzp67LlieY3yJTCWuz9NCmwybVH0vyVN/4c2DsJ7rhpBb9q0pk70LXlracmN7h1h4/iOeG721Qmnb4aWYkA==
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2017 22:21:25.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR07MB2417
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56910
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

--------------D566EBDEDAFBEDE0F1C637BC
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 02/27/2017 02:09 PM, Steven Rostedt wrote:
> On Mon, 27 Feb 2017 13:41:13 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
>
>> On 02/27/2017 01:06 PM, Steven Rostedt wrote:
>>> On Mon, 27 Feb 2017 11:59:50 -0800
>>> David Daney <ddaney@caviumnetworks.com> wrote:
>>>
>>>> For me the size is not the important issue, it is the alignment of the
>>>> struct jump_entry entries in the table.  I don't understand how your
>>>> patch helps, and I cannot Acked-by unless I understand what is being
>>>> done and can see that it is both correct and necessary.
>>>
>>> You brought up a very good point and I'm glad that I had Jason Cc all
>>> the arch maintainers in one patch.
>>>
>>> I think jump_labels may be much more broken than we think, and Jason's
>>> fix doesn't fix anything. We had this same issues with tracepoints.
>>>
>>> I'm looking at jump_label_init, and how we iterate over an array of
>>> struct jump_entry's that was put together by the linker. The problem is
>>> that jump_entry is not a power of 2 in size.
>>>
>>
>> ELF sections may have an ENTSIZE property exactly for arrays.  Since
>> each jump_entry will have a unique value they cannot be merged, but we
>> can tell the assembler they are an array and get them properly packed.
>> Perhaps something like (untested):
>>
>>     .pushsection __jump_table,  \"awM\",@progbits,24
>>     FOO
>>     .popsection
>>
>
> And the linker will honor this too?

See attached for mips.  It seems to do the right thing.

I leave it as an exercise to the reader to fix the other architectures.

Consult your own  binutils experts to verify that what I say is true.


David Daney

--------------D566EBDEDAFBEDE0F1C637BC
Content-Type: text/x-patch;
 name="0001-MIPS-jump_lable-Give-__jump_table-elements-an-entsiz.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-MIPS-jump_lable-Give-__jump_table-elements-an-entsiz.pa";
 filename*1="tch"
