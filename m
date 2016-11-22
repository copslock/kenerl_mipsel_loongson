Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Nov 2016 20:45:15 +0100 (CET)
Received: from mail-dm3nam03on0065.outbound.protection.outlook.com ([104.47.41.65]:15276
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993120AbcKVToWbgrFv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Nov 2016 20:44:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Brq4nJKMH1ACWqaE8XmTZQyUWDWrvQcyXIV4k8RWkKs=;
 b=P/5EzkbPCTZLhfyRcbwMGipWh94F3T/5EmC7AGQpsql+wAcs14iDKzzKv5gdLhqyikBSBtiISmg8HwfisaOO4JO252UIv+buLvx+NzMtL47a6aFTltDCOGf/QPZRjHCOCViHIQN9S8IbyoIgRQRQ4kG9Cf5zw13iShTm1qtZuaE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Steven.Hill@cavium.com; 
Received: from [10.0.0.4] (173.22.239.243) by
 BN6PR07MB3204.namprd07.prod.outlook.com (10.172.105.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.734.8; Tue, 22 Nov 2016 19:44:14 +0000
Subject: [PATCH 3/5] MIPS: OCTEON: Add fw_init_cmdline() for Cavium platforms.
To:     <linux-mips@linux-mips.org>
CC:     <ralf@linux-mips.org>
From:   "Steven J. Hill" <Steven.Hill@cavium.com>
Message-ID: <d8fd1d05-8617-8e12-8250-ef9f05d241ba@cavium.com>
Date:   Tue, 22 Nov 2016 13:44:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [173.22.239.243]
X-ClientProxiedBy: MWHPR13CA0044.namprd13.prod.outlook.com (10.173.117.158) To
 BN6PR07MB3204.namprd07.prod.outlook.com (10.172.105.150)
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;2:shQBX7sH7gecwcKN4Ww2ccWGtynieu+0EvCFQHtaryUebW0fGpKsXbU/J0aSMBLDNDUEf0YyVZdeNzR+bx23LH4Bqm19auBEEvTzprrD0PHOphwxd8O8YzT3buuGIg2RqUmHg586t4b9IUEOhL1+lkNLr0U/8J+yvCCeT5Au6gk=;3:obMHWg0E1y/hOuXbc/XE3yWeqF2td0vHst+Bnxmdu3StXMTR0u2epYhRMhfNMyQNoRbH0hG2DSPS8JuPOzcgBZsRH3okWFx6k8OnNXqBJ9crEwH8wjwRI7YKYu6d61kmXK1fwNQmK+uzMUv2JYH4bp4wEtDUoX1TIWcmXnflKUQ=;25:Wx3lew0y03QxF/M1fqafTwbfGX8XKP1TKS8ySptzDFC4csjfha9yOSPuivcaSBCk6I39fOwnOk7WqR9eFymVJERXSILoB8nmv0EvGNM2ZwQTQQ+Ly363vcB+1uJEv8cI79OLFfwZ9KlZHMf/EQ1J68fLLOCAUvRDPmRm5cPkkkO1xNpR4X7R2B3z44Ib+u/fFqrwDDJj9xyHAEp+fK3xTTtDO9+8g0TY+giiSueClKvd1YR3vKEintzybSP2dw6ov+XTPf0mNNdHlwC3slfHbYSGU2DpSiYwyza/mLrkLYw8Ue1XhGH2L4W7XjZkMfAqM6NFQ9V5oZj5uj7yXFnqnzoZKFo58m3xiVvmGyrG/COGVm40Aj7LcFhcn/oT4uQeVztMpuCB6SNMxOFRftgAHJdSknLPPHuqaUxWnnABz/T4EnQsvof8nd5hUmFSemuqvSL3SL2Cjqq/S7yW3SjNtw==
X-MS-Office365-Filtering-Correlation-Id: 31f50034-adbd-4e8f-4251-08d4130ff0a9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001);SRVR:BN6PR07MB3204;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;31:+FKjz85g1MUs2a0prYmBkwtWmGBgc/b00Q/b1s02qEDx0jwGlNM+8oCF9pN2VZsYonlvEhJV/2TRtEi1mQW1L64Q2QOUvOnKJvUD00CiCvRCk5VCJX2Git1clz5wOTC7Ztr3XK35zzgMv9HBA/XekW17wl2DQJ9dGXc7qrZPEfmvQ/yPmvH0UhBGvWn2xQubCMwMdg06FIBkEJrenJp23FPFkvJv01e8eGGxsregMlOxqFKBCUzsuGK6sDrXBF2KelRpaAVgeVLjPgJgObDbhg==;20:GPbTFlcwIrj+JAbpnoKjp9cBVK1dGguhovMAJDAl7EypSpJbQa+PIe4WiKEtJJ1dpJCEJZJJlUBZl5cqfdt/QtrNQhrA9pill2IqKR9Dckpmus5WuZyoKbAOeOdi0Bf7p1p+LVKmGbvf9D7upPj/mO8OIt26xAkBZ/MkmSaa7Pq1x0Ut4CulQ8nXwBPg6dlF0y6puH3QLxteEwp1WdKfK82cvI7+21683Ur1xE7t8SClZ9ydpx/ideSG5gClt6aq30knktvBkVovvevgYugGhGVdbDN6pOAAfonWOpe6ejJAMr2PK3ZKyqI+fuH1HgJi8f6E+Dx3SpJYqs9UdNaYpNZnDes5VnmEJh/vH6ZERI2Jj4Zwkf9FAVzzvy9COZxG3HcGNIbQzaBjwHVrcwoMTPDolZ98nwVXvUMI/HLIbjuAK0qdGeye/TWwxBVfO2PuXfcdwB/5i8svkmiuQIqKsuqEPzSirRwRKS/ZXSu0ISqD5nL/G8iJE8EUWDqDx1el
X-Microsoft-Antispam-PRVS: <BN6PR07MB320484F48C36999CC7C513A380B40@BN6PR07MB3204.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040307)(6060326)(6045199)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(6061324)(6041248)(6042181)(6072148);SRVR:BN6PR07MB3204;BCL:0;PCL:0;RULEID:;SRVR:BN6PR07MB3204;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;4:MKmb9DH42/RZT9B3Mb8Medti2zr/NMaZFMQecZRqiy6JhAL4aAk0oLd4v3a2T7gIe05GmhUWmQVdTezwDmoFlYSBM9wT7WYd+ks8JlWI4WUFIvXneKiHvW/AUeSlTiyNtMNy1AowcPYCfNmSHm11xWxkVSe/uO6jpXwpnU2woiXG/V3l+tdrUlJGWL0wuh9k9MH2nCBToKJ4x0eDri4UuItVaCjnGdjTm7X+utljiZSiRA95yAC1WIO/1Frq0ZYGNWf9nDTwryBHvTyuJKvgH28aQ3ImuAZlKkqdmiyFRMf9P7bKxLAUUYk9Ka/TNxiD3eAEEQ/coc2gWwzNmYMpbUuVqd1+02ch6pWj3Zjs2KBZCVLUERU7w6p+V2Tq9By7HymMN3aheu8iMyvw7eBydhtYrW7S/UvcxrYKTXWxwF3me+3LIt+PuucaWkqO7PEzppYRI5PqnPxWHgZkaZiDN2yw8pjAAZLGOOZ2Wfgmdbl7Ahy8DPBnKAJRRs5boT9dPK0oqLTSEpColE1RinGY7A==
X-Forefront-PRVS: 0134AD334F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(6049001)(7916002)(199003)(189002)(106356001)(7736002)(7846002)(65826007)(305945005)(105586002)(31696002)(65806001)(66066001)(65956001)(77096005)(8676002)(38730400001)(110136003)(64126003)(50466002)(42186005)(92566002)(31686004)(189998001)(97736004)(83506001)(36756003)(4001350100001)(6916009)(5660300001)(68736007)(33646002)(4326007)(3846002)(50986999)(81166006)(81156014)(23676002)(54356999)(6666003)(450100001)(2351001)(2906002)(101416001)(6116002)(230700001)(86362001)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3204;H:[10.0.0.4];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA3TUIzMjA0OzIzOkFJR3E1WnJ1MTFnQnllL0dWRW1XeXFMQVBn?=
 =?utf-8?B?Zmp5S0x2dG9LYzA2U2ZOUTVRMHA0ZTZmYWYybFV0M2FuQVpCU0hTWWZMbjJo?=
 =?utf-8?B?cEwvTDZiNkYxWndXOTBNWVo4bnRjL29wT2hDdCswQm5MZk5sSml2OTM5bnhP?=
 =?utf-8?B?TVZtanludmkxV0RsLy9FcUFjQ1RhdmFCU1RxazVDdy9VVkN2TmJSdmc5NnQy?=
 =?utf-8?B?YVFydU80UnVEOGxJeUczL2Y1bUF0U2M0TzJ3OTNwWllxVjZlamRmM3VjNXk2?=
 =?utf-8?B?ejFtUnFpU2N0ZzV1OW1PMmFsMFhVZGQzZFlPd200RzY1NXNTdGlJZ2VyRENt?=
 =?utf-8?B?RTlJMmZrZ2xkbmZGYXEvSk01TjlJd25GTFhsTWRrMk1pSDlrazFCYlNsNmw4?=
 =?utf-8?B?M3lxVEJUVG5GMCsvRzNDQVhvb2NtWm9LQXlmYlNSODlRSG9SS2FTbE4xVDkv?=
 =?utf-8?B?Z2ZjRWFBcUtURFlJZWVkS2FEeHhqR0VLYUduci9uRldRM29tVjVZMzBOSWpu?=
 =?utf-8?B?TTBvU1ZRZ0tlTU00MTF1MGJPRHdlN1k3K3Y5RnI4cHBSNkZsZ0tJTTZBUFlm?=
 =?utf-8?B?a2FTYWdwSzVBMFpKd0FYQmRDNDZSS2JBYlc4WWtNcHlNN2NrSHo0VUZOQ21t?=
 =?utf-8?B?bkppQ3JQdW9RTk13THlvcWNSN3lrSW53MTFGa3FqWlB0RzRyMUhycjh5Z0ZN?=
 =?utf-8?B?b2VBRHZadkFUUW1yMG1iSGdKaVNLOW53dVN6cVo2YkpYZ0c5MnJkQmJURGhu?=
 =?utf-8?B?ZTc5OGZaNGd5WCtqYVBxbzlPcW9UQktiYUo1ays2a0hlcmsxQ21DbURpTlpS?=
 =?utf-8?B?a3pHblphZ2xUeHppSjJkQWN6ZUF5WldGc1lTWXpCMGxhWThtbUpiMkliNCt6?=
 =?utf-8?B?NkpENFJxUjZLcWlkM1hLME4rcVVlVGdCSnRYYXNVZVdxQytIZjRUNE1YUnhY?=
 =?utf-8?B?ZVNTOUpTRGN3anFnQlBtVktRbGV1NVovNDVlVjk3L0lkcExFMkxHUjB5RFlW?=
 =?utf-8?B?c2VxS0NqaG5GcjFkeElvTzNSUk0yNzNYOHJTSVd4SDRRVG5SREtkR214UDFC?=
 =?utf-8?B?U090ejFSVk9PM3h6QjA4Uk9UVEg3UUNWNStWelY5S09KME5CVXZPN0tJRTZT?=
 =?utf-8?B?Vld1OVE4cVpDQVhoV0oyMmNCN2k4aDJEYlFXR1NMRm1DbU90MTFHU2gwcFhw?=
 =?utf-8?B?ZXdwWndsR3Z2OGFCWlhFRGtFU2p5TFlYSU9RbXIvUGs2aXFhTWZmREF3SVh5?=
 =?utf-8?B?TC92ZUp0K0FWbEFYNzJiWGVoMXNWZS91K29UWGZ5RDhJSjNySXJSTGdlMjNx?=
 =?utf-8?B?RTJoeGJuOFN0NS9UVmxXVjhiZFN5WThKbUZZUmppYkVCdFducnQraHJ6UnRQ?=
 =?utf-8?B?RVRXdjZqUk1WNGg0b3N2VlpZSExiQUk3VXExd0RaRWtWaFZib1UyZVAvMnZj?=
 =?utf-8?B?bEJEWjY0Rm5LTVczNWdmS0xGcWk1Z1dvb1BiS1VoTnZoVWxOeUpVbVNlWnQ3?=
 =?utf-8?B?YlVBcTBPNG1OUkpvUzlxS0lxTXhVLzVjNUFHUWFIMEYxbmMrRktISGVkSHRs?=
 =?utf-8?B?WlpTV2NpTS9LMmloYXBxRTVNYTdwb1hEZktvck5HNDFBdUMwRHVUemJtLzJp?=
 =?utf-8?B?eUhCTm9yK0tZejg3Qk1XNEN3djNzaG5uRllRTnl5WllKay9OTVhzM3pnPT0=?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;6:yZWdMe3yo8ldtg9J19+qE7nKnxszMJGEXaSSbXEIvaMDtgMcTG30QMCPXZoKyZUibOpu2TkG52JBK7LDNZkujXIp9RUozWRS9qz0PezWzvXldlZdRodfv2mh0x5thVEaxDP5/fzdtT0vg7TR11A+abzufBQmXHU415d/FSWHMPO71ydO1RIG4chEXhPPbQ4NhJ8ZZkNg+spoaKd4QKW0BwOcXdXFNgh84ZbtncEWQ3qubA5Y0r6bocx+ucZRX7uoOS8YUa4KLW8NvnxeXS3fNKXlWxL1MueWWuituKr9t1ZLEi38iDxMe7TUJ4cCu6BdPFH2QXpheqkSvmP2RrsIGyq33tJC1pEVP/g0OC4XdWU=;5:qLj1LNaNHpZJQT9cweHbPJuFaicP+U6zd6utkJfvJksEAgbUE7HAJiqmg0oy1W5GhTQGmaXJIVRf4u76Ex4Ze5+5AGnxX/0ogK0TMVlzxQR7g+0nsKN3OF1WE2FEaRIp1+sc/Uvrv5o6HiyTOFIOOg==;24:AyvfdNxID+P+Z4KDVTOyES1wPC0nx0sC+OkbQqzho57bEYdONVuJ6ePcivvhYmnvqQt5qj5IEDA00inAKXFkqhKQ8Fui4n+ysUYE1D5E1jc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR07MB3204;7:Q49kXJQkHDKEtzl0+GKyUgtbtV4RfVYRcBOtuVsYFxYe4Iz46tJkp7X7Td1h3d9DpK8TesN0ldX1FLphW/faQsX3y4oOveO1w9nStdlJgTYXd5Eb3nqvcMEchqWW5r4mgz35BxD92Bv3jGh16jq9Jibl11oLYhQDbYrQmKJeRtTshhkwV2+iY3o7RhTOjmXoD6Mx05QZM2MXRxa6N14jB7hkDB3XQOi2A4rA0QZbPBtABeAEwQGxyCAbtE1CRMpGp+ijrukqEQV6TNN2kMeuEcV6vP4kPtR6Sar5p7NVNJ1Wfi4jIuZ/m3VhvHtiFgwO1tS3GEXOBDzWLyKDvxeVrwBgh+ooRlSpzXPDfjuS6wU=
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2016 19:44:14.2788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3204
Return-Path: <Steven.Hill@cavium.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@cavium.com
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

Add platform-specific kernel command line processing for OCTEON.

Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
---
 arch/mips/cavium-octeon/setup.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 9a2db1c..4809ce4 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -949,6 +949,22 @@ static __init void memory_exclude_page(u64 addr, u64 *mem, u64 *size)
 }
 #endif /* CONFIG_CRASH_DUMP */

+void __init fw_init_cmdline(void)
+{
+	int i;
+
+	octeon_boot_desc_ptr = (struct octeon_boot_descriptor *)fw_arg3;
+	for (i = 0; i < octeon_boot_desc_ptr->argc; i++) {
+		const char *arg =
+			cvmx_phys_to_ptr(octeon_boot_desc_ptr->argv[i]);
+		if (strlen(arcs_cmdline) + strlen(arg) + 1 <
+			   sizeof(arcs_cmdline) - 1) {
+			strcat(arcs_cmdline, " ");
+			strcat(arcs_cmdline, arg);
+		}
+	}
+}
+
 void __init plat_mem_setup(void)
 {
 	uint64_t mem_alloc_size;
-- 
1.9.1
