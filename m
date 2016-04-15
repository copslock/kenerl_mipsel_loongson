Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 21:26:52 +0200 (CEST)
Received: from mail-db3on0056.outbound.protection.outlook.com ([157.55.234.56]:56320
        "EHLO emea01-db3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27026175AbcDOT0rsitMY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Apr 2016 21:26:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1; h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TjO77E/VnoF4RvMB2a6Bup3faPyBudRM4DcywDkffhE=;
 b=ceNd5LXlVkg9q4z28RomzJfRYQkJXsXTP/witJzc/nzPaSin8n2KO1+9+PtpP24nYqzAX6B/3+4zCQu1ZEYFIPkhweYiD4YGzNg6rYM8ehbtqjkIYTIQ/A/z6/rdx7V2uKJQiCA238jO5xvdggNCm9HWMMhJvgeXbaaRhajevWk=
Authentication-Results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none
 header.from=mellanox.com;
Received: from [10.15.7.169] (12.216.194.146) by
 VI1PR05MB1693.eurprd05.prod.outlook.com (10.165.235.155) with Microsoft SMTP
 Server (TLS) id 15.1.466.19; Fri, 15 Apr 2016 19:26:39 +0000
Subject: Re: [PATCH V3 06/29] Tile and MIPS (if has usable __builtin_popcount)
 use popcount parity functions
To:     <zengzhaoxiu@163.com>, <linux-kernel@vger.kernel.org>
References: <1460601525-3822-1-git-send-email-zengzhaoxiu@163.com>
 <1460603162-4670-1-git-send-email-zengzhaoxiu@163.com>
CC:     Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
From:   Chris Metcalf <cmetcalf@mellanox.com>
Message-ID: <5711405D.5040807@mellanox.com>
Date:   Fri, 15 Apr 2016 15:26:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <1460603162-4670-1-git-send-email-zengzhaoxiu@163.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [12.216.194.146]
X-ClientProxiedBy: CY1PR20CA0042.namprd20.prod.outlook.com (10.161.165.180) To
 VI1PR05MB1693.eurprd05.prod.outlook.com (10.165.235.155)
X-MS-Office365-Filtering-Correlation-Id: 4b0e61cb-fa09-4752-f96c-08d36563df38
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1693;2:HSfGICSV4ENeEgxgmaDNxwqWfP7OxHwGyqyK7pVriVmq/lTSJmJEEew3t7l/gXOIFnCHzcejn7DgD5SbgQxfjazQXscTLlOYCoYGLcx+cqpTLlo3v+6uYyuOYcTG9eacX/TbdDHMXO2X1hcxS++o/MSmCYJCMOaVwjE1FtIQvvmUWjOeHoNJCCbJYhHpSGAM;3:dOrCIkNK/RcYp+VcKx0JTLs/1nV3XhB/UG08lvanMFQtVtdmFU/5L/u6DbnDzUPeII+uWGwfb5kUapwQdvOtegOaI0CLBgJxHtsLXjhBjedQ5ZQn3pvtmNzC2pZIfhG8;25:aye6quygi/5Y+z1MQrTd6T9e2S6KCPhhPHWup2eqNOM7V+MGwOV8eS40jmfWB+MMotHBO784ShnQqJkDxTfgAwAtge/CK9AVcYlJZ7lTfOsQv//lFVncKw/QSQp2DZsukJHeGneA4nSTTx1uDcVZVopa+JLcbJLyslhTByNXlvmhFnwq7CSHavY2x97BYAwiLisUQsquTCl1rE3gft5xZ4WamjG6O6mSn86BKdZM/gkWbtZ+qc20nZYntT+0z48RqOWA9fDNaww3cEPB40FM5xmrhp+rXMSJlS085pFLnlcr/SOxVmUOLSQrgStQJo7sfoF2/NtoDlG1a0AOwXA+bg==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1693;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1693;20:rcQ5g/9QV1hK8Y9ZzDG+jjcmPwPQI2Nun1XJw7wjP9XSUBMqjOXyGRa+xth01WvBUTBqLk9MYtCH1AfXv9RuuQWgIcT8F13/yZmp1dsIgHBn2d0EygZJ7jkn3VoIRNQbenyi8nwf1yojep2hZJgib/NKxiRTCRbQRcK3C2IWUrvfOm7MEaoiDUrLkM6S/vqAeDT5IN8psnqfRAOt8C4K0lvEXjQziHXGNhforj9n35MpTklF/Mlg6WjzMLLZ4UrO5d8TdMaeZ2e6kl/UiJ0OU/AfSgDr0TXs8/S2QBK+Ts0gob4iul4kRsqz9ujCDZNNESPbUWSR1c6JqL7peJb1oLkw18ptA2Di41T618Kf3VvwX23edF7MoYkTRESCfmBPbwGB2VMHx+bTa7lU2CvtLdbDsPkO+NBSjGuTkNkhLx6+zV8/5lHcr1rUKA7kIG8AFxLRglSTKnZ2/gaGMeMUEGCCyHY6QZByZCNX+cRkPhLwcghDdNHpRNWSdw18X/rF;4:xNcxxYqWVo0eBDHFGAqGqAH71ZdF2QCEqC538GxBmr3DmSkmXovUM9BxLA8wtBfZ0b5bmwy18D/r8fuABf71JxVYtGUobponoWlIEnTBS50xsq0TtYe6EHY7WE+x6TUhXmzuTEzpZj3EbgMzDdr6x05GZQQiqtZ5/YsnqLKhzDlsI1WmaJCacz/D3ibLam9NffVOOu2fEtY6MvnnYkyqHzz8tEHjMgRiaJUj1xDUChmJrWOu9rVQWZPFyFYobXyBZ3bclyUjsj74QOklcdVDoM9i+Y4mjB1a3bZywv9xkFTlzGRm6I1XzINPmwCxBix1fn+fGg2zIQRUigmEB9fwG9xSYz/2LZXeGt5PclGMogZIWSjh7PzcEs4SAw+7F/Wy9oakowrPxp6c22Sm5mpzq7DYY31DMDgXpqbcQdkQhl4=
X-Microsoft-Antispam-PRVS: <VI1PR05MB1693A3FC973746EAC7353FA9B2680@VI1PR05MB1693.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(9101521026)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6055026);SRVR:VI1PR05MB1693;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1693;
X-Forefront-PRVS: 0913EA1D60
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6049001)(6009001)(377454003)(24454002)(5008740100001)(23746002)(59896002)(2950100001)(66066001)(5004730100002)(65956001)(65806001)(65816999)(54356999)(47776003)(76176999)(92566002)(87266999)(50986999)(99136001)(77096005)(4001350100001)(189998001)(15975445007)(5001770100001)(42186005)(33656002)(86362001)(3846002)(81166005)(4326007)(36756003)(80316001)(2906002)(19580395003)(230700001)(83506001)(19580405001)(1096002)(6116002)(586003)(18886065003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB1693;H:[10.15.7.169];FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;VI1PR05MB1693;23:d2/ZlNudOSFMMsabkdBTl+VclQ7F8lc5tfapO?=
 =?Windows-1252?Q?rmqnCsL9w4PChUSTV1+moEOLfbtCWpgirN0rA1eEqX0EFxdQodT/7JnO?=
 =?Windows-1252?Q?cqVePA3TEdEP1s+MGQSEan4i3y+gmcKlXCjaYPGk1nJo64Xxyqd5fNpN?=
 =?Windows-1252?Q?W/M0IHVmqKh/0NDZwGu1m3g0FuMHhRazfOPW9btPfdCUUgbySdqie1IL?=
 =?Windows-1252?Q?hayq3oOQMTxCfhXDKFV7jJiEAtMhO53qI+GJE/W80HCe4goq2WiaFta7?=
 =?Windows-1252?Q?x6FrUBL4kW7PQIMpzc2DftjZrwqHdbplPO9WmlIuphjgHh6/8Y0qPfdT?=
 =?Windows-1252?Q?mvj+8sQgSKaEC9hMEb3MaNmkDpsFOYgG13v0IdKbrB5xhDWqbGvFWFjp?=
 =?Windows-1252?Q?45TaBZXc3jLdfx5tSfMKQqlgMtbcoSMVMav+V5zDzGa5GGgAiXPk2Bp3?=
 =?Windows-1252?Q?hG5cUbt7EIfFC1EcyKyWFJIij9E9XVZK3YAkmNeerG52aYqKV8l4EEbj?=
 =?Windows-1252?Q?8pFoLpFsYVXBeQ0aCD3Oozm0hwaWDIXABXMx4r2nurWO88QHljxNVDBL?=
 =?Windows-1252?Q?i6xZBX7JSxNSnDPB3VNTtXq1YRtq1IFJMB/TIcAo0ctKUU6uDc2VddwN?=
 =?Windows-1252?Q?8sWhgKa5I4YilxTr8DeK+1QQttQDvD+B32IO5fdYc9T3iShkVjUeBDNL?=
 =?Windows-1252?Q?YaPTVhUbUy6po3n1KCWy1I8u7v+SaDKp0eQ1oThESmclqGHyI+VNz7Zl?=
 =?Windows-1252?Q?WxlHi12NkAuXEi17XcKxNa47lc9h6B0VC3lNfyX2iPS7cpiDazvbHXDb?=
 =?Windows-1252?Q?OYdMEDB8aiF6J2J2GRmKBgtrH+uxK00jSo7wQ/WEqCw1WxhDQosrzbbm?=
 =?Windows-1252?Q?xYHwklPkq+/oCf3Fu0ww1T9Qqsd/h3QShWmH3WnwAzgYcbfh5a58B0dG?=
 =?Windows-1252?Q?Kib7bWre/98oP4cHB/IUFFVAL7CrdJNGsS4x5MOIM3LVbOFsOSO5RBsQ?=
 =?Windows-1252?Q?fscbMnuduizZ0yR2bH+OS/3P4UKxW+RWSKSynct+wOIQEt+/WpiwW+Sz?=
 =?Windows-1252?Q?oefp7jtmyjM/8fvnHNwiN5HefFzBpBhHh2RK02gx7H8Au/zo4LugqaNp?=
 =?Windows-1252?Q?7rA0nop47ZXSR/c9aB8i8YI8tpfSe6gubg3pvQQe9We89WhBAALaWAsH?=
 =?Windows-1252?Q?u8cZPdpwxbgaz1dRnC9m6nJQ3K1qFj/5wwfMCbFtPCpaEn8itS/?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1693;5:lW88AvfdcWe3i/ffLpvTFQ42ilcrpKcHa6LfiW6daZXi+nlyZjdrtg3Ok5PeLNOPGCICVlnDu8XCLoa/qKMJqAGx2WICFmOmTyX13/0zyj07EzsTAEkDaLO0NcEDtBAVT3mqfStkANZKONLjRA3kPH6OYjwhZsFIKjZjeisiVrWCrFVkv1sM/rz++EMUVFBL;24:7pwzWoCsYoHegAGlw0PdsuWBnIUFByjsxUXCk2mfA1URuxVjU3X6DXC513EmH+vvL1P/SLdacGt0cz3Eqrl+KwDpjAlfdOO1Drq7hAAG5Ds=;7:XiZKXDVwHszH5h5qFMvmuQXrOiJ5VDSy+mAno634yISidKS4jUhWqjfKz9asLp6cVkvXCEOXBk81etUE/M93WuLVrirBvVqxQ6z8BaeKIp1OMliFGvXrJQ191gqRIzipcNwkcHw82jIHt7IYsYxYEaN+alf9g30gtFTcYc9Cfvuge85sASdt+O8fZ3EhI1mMzzdYaKWHQgvtKTCYhxNOF9WF8cApG+/nlL8zkYxTq18=
SpamDiagnosticOutput: 1:23
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2016 19:26:39.3560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB1693
Return-Path: <cmetcalf@mellanox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cmetcalf@mellanox.com
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

On 4/13/2016 11:05 PM, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng<zhaoxiu.zeng@gmail.com>
>
> Signed-off-by: Zhaoxiu Zeng<zhaoxiu.zeng@gmail.com>
> ---
>   arch/mips/include/asm/bitops.h | 7 +++++++
>   arch/tile/include/asm/bitops.h | 2 ++
>   2 files changed, 9 insertions(+)

Acked-by: Chris Metcalf <cmetcalf@mellanox.com> [for tile]

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com
