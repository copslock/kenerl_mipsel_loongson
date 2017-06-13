Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jun 2017 00:29:06 +0200 (CEST)
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:23616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23994624AbdFMW27BnM7u (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Jun 2017 00:28:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pHRs4QRgU6q9c6shJ8kL8lVwlNo9UpPH5K16koDuoJo=;
 b=mCsT/xXO8om2f4DlPNaNeNqbDDsiscuyLyp2mHy9D0ig78csIwWn0TyaHngc2SuMMkp39/k5QtXpu+/BnFbn59FvTgwMA4opXxsfM8sOHdhAcvvVPP/sHhIpu+MckDeHiGk9ZQTkFL9KVQvkkDa9hztYoatXBciaBdtDMwnANGo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com; 
Received: from ddl.caveonetworks.com (50.233.148.156) by
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1157.12; Tue, 13 Jun 2017 22:28:50 +0000
From:   David Daney <david.daney@cavium.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v2 0/5] MIPS: Implement eBPF JIT.
Date:   Tue, 13 Jun 2017 15:28:42 -0700
Message-Id: <20170613222847.7122-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.9.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0048.namprd07.prod.outlook.com (10.174.192.16) To
 CY4PR07MB3496.namprd07.prod.outlook.com (10.171.252.153)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR07MB3496:
X-MS-Office365-Filtering-Correlation-Id: 8b2049da-cc03-4949-e9e7-08d4b2ab914a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;3:N5eVQM5X9y74qrpIcND5aDktUpO1BV6sB2FqHumB3DeIhZVuyu6e0OGOSZSGxTquZ8A1kbBCG1uCmXKal0MTt2boRX3G9zqm8j2zYiw5aoAFT25oC/q8gMdaparsfUfWbseGe9L1h3UoT4YWEPr1agxmTyWqOjpCtq+YytvFuYQ9VAAJ92Q4y6Xe8ef3mRXjnc9kLR4cICqRhCiRzrYfsCW8y6rXd36Rg3rNlTlQdw/jL8B8nuAejeFUFYE/FcqAZw0Xm8++FIscv9O0aX/KshYlPuYpJugl7boX5OtJQU/cO8kQy0Hk1WmBcLDAeF7dLsO+rNI1eDf80o4FvdVfjQ==;25:Wt+I1yu6cfaHiU57fmjI7O8F1fU2+tgb959eOS43r0z78gtBbLxY1/GUvA+vU2H/IpDQJyjCXQx41Ums74COSjdNOPQ/7Ymf9jdsn5XcbGQRLcGMYc0lFzTHjF3yy4qr1Y3AVMblXJtfFjQi3gsH1wD53gIuSDvpMdEJRQQJhzQn8qXPxFAKPgEdYsvixb31ed0gZLyfdG1/zFY7qt5VIvqSNSYvez7wZl7G4hRMtwTI8oApe5gd6YtoM12MQFPvzRyxMlV2oeDWsaryZruPHHVQzoKsDz5FwusHlE3MzIoVclAPELbtJKzAUf2kfwLPhhyFPR99RJAT+O07gmJlGFVUurYOAJWCjzjJ06Lz+JuiAKa2gNeTEVLOdtlX3WR04U0SwcoPfo/H1OnjwNRbzm8efF0DOfw3IbgiHCVmLhMJpm7OOWaOM7aXIktttEDGylV12OODMgq+RFBbEozSicqbzxSNqOKqF79xwjButTY=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;31:A1QN8Qba+g/So4QbPCxkW/lgsqPGQE/DuKwZm2bHRxwKRUbxbQwVf2hNMPKqtlE+Bg3vRKOCxdcJLMfc3s+NYHbZt9fhHJGiS69g8+Gfori7BRytyMiLE11sZvhsXbu+MFX5CmGYNX09b4Lr7bTsl+16uZVK2xZ7SCEPIAzfCQ1Z/ED+LfCUGLShnTKEtAVG93atOLyYSN1K8uV8akypLlr8t1s1lYQiMXZujmmsJ/A=;20:Q0+d68zr+INViLGq5sjnRQgMNNOh1s9KcWsFCFMPtCNA8PrRenT6KUQB57pDzEmFqD9VpagiW21tH8tgX4+znhdJOjx2Uoh+hqo8SMHuFVx77YPA6RFkDvfHbT1nYVmrwTlwGCUhyaXo0+biDkkXAnJ40XhPW7E7VpjwddFLQ6allFT8BmMvUHpW3pPgkbOHyB0NZFUmJV+PbngIy7S8MG/ImVYVcki18BQvKSdC1w407m4ZHKgnwY/NfFNTBdbmp88wVjrL38T5+q3tIt/4b3ZkRLAY1Bpq/25vNBt32ci5ktiGU4KplHlgzf0Qj5kCkhsVUbedmY0wfrULCYxY/OHm1BxiJ92t/wUGpusX3wfn8C81xrrsPgo1ZpArEtF/aRkm2xjYa3BQY88nhIdgNjXdFzivP0umNFi1kfoXO4q5kg5jwKppDrORDvg6gNEZ6TZfBbNSP8+L/j5q88uOpmlWZccGj+7Md4H3F/8uMrbUzVcxCosE+FoEFI8JL2WZ
X-Microsoft-Antispam-PRVS: <CY4PR07MB34964ABB225E6065BDFC11BB97C20@CY4PR07MB3496.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(100000703101)(100105400095)(93006095)(93001095)(6041248)(20161123555025)(20161123558100)(20161123562025)(20161123564025)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR07MB3496;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR07MB3496;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;4:gTuhY18OleQ3xPXRavQ7VfpCfaLltg39V83UYiEp1S?=
 =?us-ascii?Q?3dRFOYE8bBtHEudP5rB4UmBCJorAK5PkS66YP8ZuymhCqtdnbS/5v+Oemzkg?=
 =?us-ascii?Q?/8xk9LZn97qSNs4ihtVAHJigGR+HSTVodGi7LCBbNfAZuo2ObBpsuRKnpc5f?=
 =?us-ascii?Q?YA85XbgAMCscFUFlrm9YQpbZhXW8Qn8Osw8tUWNSujv3aXVMV97aZ3pB2f4s?=
 =?us-ascii?Q?dbekAwwHraKdYuYQB/EO+vIr8yWs3s0/7SADGrseapcDrReeQPeLtakr94KO?=
 =?us-ascii?Q?pzPdccdID13myAnwVG1Xe/CO79dO8petdjHomZbVxiBA/BvN47nuDoWO5ckj?=
 =?us-ascii?Q?+PQRp/deG89StoyZ1s3G8gKMAhsq07UDoVScJiUSYIs0bxnSxYQFW3Usn/Yj?=
 =?us-ascii?Q?OSKvON7fpS+CBGmuisSGMA0vrqsIcYyQpdxdR4PDyqWe3ZvxpzaOsWG4yRfH?=
 =?us-ascii?Q?v2/lm247Dhd9jcjVb0LvR4HJTgUZwQ+WKYEaZdZ9pcFY6p8Y1aVbaRza+0jX?=
 =?us-ascii?Q?asGEtQIkMeMQvOaVLIpMHqw7+XSQ+02wWkX7BXNtEhlrehfG6F4KxzvXLOfV?=
 =?us-ascii?Q?OfglQE0ZuzlbntjL/rXHHlNoQ4W9Tq890WBJEqMLlFZBI9TCdWfdEKWz87UY?=
 =?us-ascii?Q?gNTm2kCyW1RBsgfsWv2qjY7pvAXQ0e/XF+NfAL/tq0oVehM48myZ7yKyrPsH?=
 =?us-ascii?Q?p2PZP6pRnhTEv5cZI24i1XoLRHzK6fHhR36d1CbcCNoLsez/g5eMtvY6yBGB?=
 =?us-ascii?Q?n+3kWxzWFiU2vRMCAda3aGA9hUUewa4ZuY9C7+GKuuO7u6tdrBKt4kuF3G0b?=
 =?us-ascii?Q?XB/EnXYPVSkJOxuq7EMQ5yLBo/bmYV6Yo6TcyDsbvZXpe3mtRE+1d5heZVdW?=
 =?us-ascii?Q?7bonOBEDtjvu0X6yhqXeBMxUjxEueC/4RlKGWYxJKXrjswVdnSE9M0qbiXXr?=
 =?us-ascii?Q?tDlcwnHJPzdsbJ19LGdeIJghkwMHAMexvXpWczNS0pdfY9z4mwyOaV8cl7k1?=
 =?us-ascii?Q?cFEQ5FofKJa5VsfX6DvVUzztWt3kvyY9kKtciJbNKTbBhW1gPdt1DEyKColJ?=
 =?us-ascii?Q?DYZJCs+O4FMtYOYuGzfz3ZkFuSmKIzTLTG4KkiTSCWYAJfBxkC5uSGJr6fuQ?=
 =?us-ascii?Q?ImIENJwpOUau6ZpgyJ7Wse4zQPZ+Yu?=
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39850400002)(39840400002)(39450400003)(199003)(189002)(6486002)(1076002)(6666003)(36756003)(6506006)(105586002)(53416004)(42186005)(33646002)(106356001)(101416001)(50466002)(48376002)(50986999)(72206003)(6116002)(5003940100001)(3846002)(50226002)(305945005)(97736004)(7736002)(189998001)(81156014)(8676002)(68736007)(53936002)(86362001)(69596002)(38730400002)(4326008)(54906002)(47776003)(25786009)(6512007)(81166006)(5660300001)(66066001)(107886003)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3496;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3496;23:OG9VCgH4BV633jTmPR2y8zbY6X5Xy6ktI4RNuBQnB?=
 =?us-ascii?Q?iMcQZ2vhifd61KdAX292Z8LYVpn7pX2I+Yo1D6UKQX9v0bfdXLC1+6eNy93W?=
 =?us-ascii?Q?2S4akI+LAATWneyN0qknm5y0KSlHod1IaZ5o+yXAqKLxQnoJvhxpxBwdbQsT?=
 =?us-ascii?Q?H+VaHKLvKOsTXUPvs95ETWzY3R0oetxq7819nGyYYR26Q2k4aNFVgckZeFtV?=
 =?us-ascii?Q?5XHrgHAZTJAxKNKuG2eh54hddol+j9Pq3fBNbURFpDFF7dqOFCQYIv85zvnL?=
 =?us-ascii?Q?90C4v6gQRVmYNW/IRKqzmgX6Xunr9qmswJCN+hhJOq4y3WKlR1vJhGpQc+wX?=
 =?us-ascii?Q?tUvZifmiD22iYg7pcAAsreVapdzy2wZ/PbI8/2CckLOWQ+Ec5Vc+X/OLicXA?=
 =?us-ascii?Q?6eZg0iLRQkMqwCPmbDzUtdlggbj7+/r6JgRIxGo30khi/a1/6mcDtZTjeEbv?=
 =?us-ascii?Q?A5bwEmZ7ITIZo1sXmFDRUNiJrpmoluQkmet24YrGoXEJNStFT+4lr6BX2ekk?=
 =?us-ascii?Q?jpJw0lunS9pOz+b6Qwujx+1cSNjPyPBb9lGPKrDBSl9JoDlLUVbrOI2G9v3i?=
 =?us-ascii?Q?RIfov6QdoOssd/3VZ0zUC8Ye/+4FpHLLxXlDrGMK9LwmJN11Vq14iPE6YG5R?=
 =?us-ascii?Q?Iv3A/xZ3O9TJ1LcDL9osYkCrReWaEvCQVPWaKgSqN9KFXYwz27FxWWui4PDf?=
 =?us-ascii?Q?LIHqigK2yZ5nm1oHt24+6G4EZPrh+odbA69phsy8NjCrGn/078PaJSE1MMLQ?=
 =?us-ascii?Q?NumZCZcCrP+RyekNrbUpECuQY7y9Rhm3tCI/KcvOKQSgPp/NMQVcG6BM2T13?=
 =?us-ascii?Q?I68uuHZRLiB9FnSm/xblpkVIKq7l/z63NTsE/wpZ8FYfavfNxLa7qPgLW5kc?=
 =?us-ascii?Q?sR/wqKq+XsL9v6zYCGq73QYcNJEsrIgP6TwHEr1hdTsYDGy8aq+7xq3KxY4O?=
 =?us-ascii?Q?rXRXMFBq4MwzKS5lw6n9w/EPMrC7Jk1/OPfHSRK95JZnEVLY3QRyhG42ha00?=
 =?us-ascii?Q?2AN0wisRCGcMVk4+OObGTEB31LdYKRjGC26YKF2UO6Kr9MThTC3rCqt+Mx65?=
 =?us-ascii?Q?JrTCm3325ffwudvrANtuUQFGsqJcDLUcYbdD0CJUy7jaPMT7HnwXv6MerOr8?=
 =?us-ascii?Q?dUMlLLWxBxPrM9TnAnfR1uSUGuyOHvU8hs+2KsLX0RlnHwJ7LDvpMHzDe5Y5?=
 =?us-ascii?Q?TGBSNAhenSh/pBHBss5wXk0mQLlJwdZcItUGcJ6c4OodwJar3dagBvglQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;6:Ow7Q8BHhYZWXp2lpXAN1vLiOFk/QGU6k0ZBhG7dtsaTESMPf0Ydc640P/FRDCLaGfRc9TD9bv6KdRz+YdkrMO+IqptiXAb3I6m5XDGkkn5APMNIDNM6LcfhOZZSQG/IzazpGIddFHz+UrGMVmO/1YnPGKhnpFcTQ0RxoE7Q9+CVHjwMJyBWk5RXJOaEJp1pTnSQdSaRqLwObWvY4w1vJY0z7LzhN4RqlK1TPdeByOb668SN03S0Mw0aSjWWnpftGQxaNlzFD4VzE+m/CqIHEtTJCUvARJRTM5YwtYBM63VY32LLgODmdz3R6aijQWAyVg6aoWBjj5EtNwOUETf/BIyqrCbZbFD1ecZmnzeDs7EofezsTJSoiMc+GztfZiU/KXF4mebTKDa444K7xrFviaIMKxtCruRS2SFoHxDWPVOgLH7sasSVUI4g9lxQbUcT2aq5fmCZEbSeFXV94GL/h3rwriKrudbWMoM+uZC1y/HxUB62YR+ACJMLvUZcMiuW7OGD2mjaZR2dMAOWxfiioFw==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;5:YT2hGhLm4PSXyk1aFQ69F9OKqSkvFwqbBqIe8rxVVq+KqoYIukUsFKw2r0WKPOs3NE3xq/RuS7kuPvTu/0Cz4LQLTov2QdWe8ZFNM8yfReo7Me3RBzTUx99yRej/mGSBxWEsV4pn88FmTvmI8a3FDJm9qpywmxue3SoaUM57ODwt29x227BHHLmKUQDj4dWQYU0qC9pHeM/TMaM+3eHc+kTesHMpAwn2BK2KUk//FvEaoxVd/H1RU4ARrqeBZ1n/IX6fsyZAtAAj+ORsHq15+3EWPok/PojYEPUwQ62U1s22imL8GZaZ9OiZZNbWEm7V/ULfcj24aeKOp4DmoFcoQiBfAwG+czO3rEtt0FE7Ge+1d7n98CYm7bBBt3MzvhcEbVwEc05jpjMWVbWBq0PqiBBi9AgTr9eqJplmM7pXpZ7jaajbAgBpeLyeGZ6YIQPI9lo7NsSyWEMpA6iABK/9rEDhIy1Y5wy+z8TbAK+54hbMMzkiLxu5oQCSDkhNwTNj;24:NyezORKnX+sGpmIieLLl7oEVg6y6EsoJ3G/fMpAYv5ZQe+j5om7C/JQwGj7AtMPYozq36ziE68HTY7fKT7clpyK64Kg9sMJJkBBUT+0I8+0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3496;7:qoZJGAzKep+uLNLUhvvDLl1fn6oQIZt7X7Ui7Bgqq18CBVbKeMWGbP72uYvaxr9ou+CduAQNV+8/9uLehiY1UCt/dKRTqBZjJ8d9q2jBam4pRXummDvvIxs25pvnivJBkEZeNZ4cQL5B1LTdyJqPuAAe6VyvApDYOmcN2GKqz+EeUSwoJ/UiIukonVZRcGPUttNxsciMydFUogLPceXEfhXKClaqUov87+0SvfmGW37BfAYD9SyIbvVFhVhaanSsbit/cux4lSGgd3G9NAiYRDPTUhJvkv8Yp41AY3JFQGPGpZA/bDRIkj+FUTr5k28F/dx+uqgR+2dUGk23Qda5lw==
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2017 22:28:50.7683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3496
Return-Path: <David.Daney@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
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

Changes in v2:

  - Squash a couple of the uasm cleanups.

  - Make insn_table_MM const (suggested by Matt Redfearn)

  - Put the eBPF in its own source file (should fix build
    warnings/errors on 32-bit kernel builds).

  - Use bpf_jit_binary_alloc() (suggested by Daniel Borkmann)

  - Implement tail calls.

  - Fix system call tracing to extract arguments for
    kprobe/__seccomp_filter() tracing (perhaps not really part the the
    JIT, but necessary to have fun with the samples/bpf programs).

Most things in samples/bpf work, still working on the incantations to
build tools/testing/selftests/bpf/ ... 


From v1:

The first three patches improve MIPS uasm in preparation for use by
the JIT.  Then the eBPF JIT implementation.

I am CCing netdev@ and the BPF maintainers for their comments, but
would expect Ralf to merge via the MIPS tree if and when it all looks
good.


David Daney (5):
  MIPS: Optimize uasm insn lookup.
  MIPS: Correctly define DBSHFL type instruction opcodes.
  MIPS: Add some instructions to uasm.
  MIPS: Add support for eBPF JIT.
  MIPS: Give __secure_computing() access to syscall arguments.

 arch/mips/Kconfig                 |   12 +-
 arch/mips/include/asm/uasm.h      |   30 +
 arch/mips/include/uapi/asm/inst.h |    9 +-
 arch/mips/kernel/ptrace.c         |   22 +-
 arch/mips/mm/uasm-micromips.c     |  188 ++--
 arch/mips/mm/uasm-mips.c          |  238 ++---
 arch/mips/mm/uasm.c               |   61 +-
 arch/mips/net/Makefile            |    3 +-
 arch/mips/net/ebpf_jit.c          | 1949 +++++++++++++++++++++++++++++++++++++
 9 files changed, 2285 insertions(+), 227 deletions(-)
 create mode 100644 arch/mips/net/ebpf_jit.c

-- 
2.9.4
